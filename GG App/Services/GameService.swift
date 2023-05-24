//
//  GameService.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 14..
//

import CoreLocation
import SwaggerClient

protocol GameServiceProtocol {
    var username: String { get }

    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void))
    func submitAnswers(answers: AnswersDTO, completion: @escaping ((_ data: GameStateDTO?, _ error: Error?) -> Void))
    func getState(completion: @escaping ((_ data: GameStateDTO?, _ error: Error?) -> Void))
    func submitScore(completion: @escaping ((_ data: Void?, _ error: Error?) -> Void))
}

// MARK: - Multiplayer
final class MultiplayerService {
    var username = ""
    var lobbyId = ""
    var isHost = false
    var gameState = GameStateDTO()

    func joinLobby(lobby: LobbyDTO, completion: @escaping ((_ data: LobbyDTO?, _ error: Error?) -> Void)) {
        LobbyAPI.lobbyJoinPost(body: lobby) { [weak self] data, error in
            switch error {
            case .none:
                self?.username = data?.username ?? ""
                self?.lobbyId = data?.lobbyId ?? ""
                completion(data, error)
            case .some(let error):
                completion(data, error)
            }
        }
    }

    func createLobby(lobby: LobbyDTO, completion: @escaping ((_ data: LobbyDTO?, _ error: Error?) -> Void)) {
        LobbyAPI.lobbyNewPost(body: lobby) { [weak self] data, error in
            switch error {
            case .none:
                self?.username = data?.username ?? ""
                self?.lobbyId = data?.lobbyId ?? ""
                self?.isHost = true
                completion(data, error)
            case .some(let error):
                completion(data, error)
            }
        }
    }

    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void)) {
        GameAPI.gameLobbyIdRoundGet(lobbyId: self.lobbyId) { data, error in
            switch error {
            case .none:
                completion(.init(from: data), nil)
            case .some(let error):
                print("-> Error in request getTasks: \(error)")
                completion(nil, error)
            }
        }
    }

    func startGame(completion: @escaping ((_ data: GameStateDTO?, _ error: Error?) -> Void)) {
        LobbyAPI.lobbyLobbyIdStartPost(lobbyId: self.lobbyId, completion: completion)
    }
}

extension MultiplayerService: GameServiceProtocol {
    func submitAnswers(answers: AnswersDTO, completion: @escaping ((_ data: GameStateDTO?, _ error: Error?) -> Void)) {
        GameAPI.gameLobbyIdRoundPost(lobbyId: self.lobbyId, body: answers) { [weak self] _, error in
            switch error {
            case .none:
                GameAPI.gameLobbyIdGet(lobbyId: self!.lobbyId) { data, error in
                    switch error {
                    case .none:
                        completion(data, nil)
                    case .some(let error):
                        completion(nil, error)
                    }
                }
            case .some(let error):
                print("-> Error in request getGameState: \(error)")
                completion(nil, error)
            }
        }
    }

    func getGameState(completion: @escaping ((_ data: GameStateDTO?, _ error: Error?) -> Void)) {
        GameAPI.gameLobbyIdGet(lobbyId: self.lobbyId, completion: completion)
    }

    func getState(completion: @escaping ((SwaggerClient.GameStateDTO?, Error?) -> Void)) {
        GameAPI.gameLobbyIdGet(lobbyId: self.lobbyId, completion: completion)
    }

    func submitScore(completion: @escaping ((Void?, Error?) -> Void)) {
        ScoreboardAPI.scoreboardPost(body: NewScoreDTO(lobbyId: self.lobbyId, username: self.username), completion: completion)
    }
}

// MARK: - Singleplayer
final class SingleplayerService {
    var username = ""
    var score = 0.0
    var round: GameServiceModel.Round
    var answerCount = 0

    init(rounds: Int) {
        guard let filePath = Bundle.main.path(forResource: "SingleplayerLocations", ofType: "plist") else {
            fatalError("Couldn't find file 'SingleplayerLocations.plist'.")
        }
        // swiftlint:disable legacy_objc_type
        let plistArray = NSArray(contentsOfFile: filePath)
        var preparedRound = GameServiceModel.Round(tasks: [])

        for _ in 0..<rounds {
            let randomIndex = Int.random(in: 0 ..< plistArray!.count)
            let randomLocation = plistArray?[randomIndex] as? NSDictionary
            guard
                let title = randomLocation?.object(forKey: "title") as? String,
                let lattitude = randomLocation?.object(forKey: "lattitude") as? NSNumber,
                let longitude = randomLocation?.object(forKey: "longitude") as? NSNumber,
                let seconds = randomLocation?.object(forKey: "seconds") as? NSNumber
            else {
                fatalError("Couldn't find key 'location' in 'SingleplayerLocations.plist' for index: \(randomIndex).")
            }
            preparedRound.tasks.append(
                GameServiceModel.Task(
                    title: title,
                    coordinates: CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(truncating: lattitude),
                        longitude: CLLocationDegrees(truncating: longitude)
                    ),
                    seconds: Double(truncating: seconds)
                )
            )
        }
        self.round = preparedRound
    }
}

extension SingleplayerService: GameServiceProtocol {
    func getState(completion: @escaping ((SwaggerClient.GameStateDTO?, Error?) -> Void)) {
        completion(
            .init(
                state: ._1,
                players: [
                    .init(
                        username: self.username,
                        score: Int(self.score.rounded()),
                        isPlaying: self.answerCount < round.tasks.count,
                        hasSubmittedAnswer: true
                    )
                ]
            ),
            nil
        )
    }

    func getRound(completion: @escaping ((GameServiceModel.Round?, Error?) -> Void)) {
        completion(round, nil)
    }

    func submitAnswers(answers: AnswersDTO, completion: @escaping ((GameStateDTO?, Error?) -> Void)) {
        self.answerCount += 1
        answers.answers?.forEach { answer in
            guard let task = round.tasks.first(where: { $0.title == answer.title }) else { return }
            score += calculatePoints(answer: answer.coordinates!.clLocationValue, task: task.coordinates)
        }
        completion(
            .init(
                state: ._1,
                players: [
                    .init(
                    username: answers.username,
                    score: Int(self.score.rounded()),
                    isPlaying: self.answerCount < round.tasks.count,
                    hasSubmittedAnswer: true
                    )
                ]
            ),
            nil
        )
    }

    func calculatePoints(answer: CLLocationCoordinate2D, task: CLLocationCoordinate2D) -> Double {
        print("distance: \(distance(from: answer, to: task))")
        var points = 100.0
        var distance = distance(from: answer, to: task)
        var penalty = distance < 500000 ? (distance / 500000 * 100) : 100
        points -= penalty
        return points
    }

    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(
            latitude: from.latitude,
            longitude: from.longitude
        )
        let to = CLLocation(
            latitude: to.latitude,
            longitude: to.longitude
        )
        return from.distance(from: to)
    }

    func submitScore(completion: @escaping ((Void?, Error?) -> Void)) {
        completion(nil, nil)
    }
}

extension RoundDTOCoordinates {
    var clLocationValue: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lattitude!, longitude: longitude!)
    }

    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(longitude: coordinate.longitude, lattitude: coordinate.latitude)
    }
}
