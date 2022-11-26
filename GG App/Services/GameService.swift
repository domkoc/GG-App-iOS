//
//  GameService.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 14..
//

import CoreLocation
import SwaggerClient

protocol GameServiceProtocol {
    var username: String { get set }

    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void))
    func submitAnswers(answers: AnswersDTO, completion: @escaping ((GameStateDTOPlayers?, Error?) -> Void))
}

// MARK: - Multiplayer
final class MultiplayerService {
    var username = ""
}

extension MultiplayerService: GameServiceProtocol {
    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void)) {
        GameAPI.getTasks { data, error in
            switch error {
            case .none:
                completion(.init(from: data), nil)
            case .some(let error):
                print("-> Error in request getTasks: \(error)")
                completion(nil, error)
            }
        }
    }
    func submitAnswers(answers: AnswersDTO, completion: @escaping ((GameStateDTOPlayers?, Error?) -> Void)) {
        GameAPI.postTasks(body: answers) { data, error in
            switch error {
            case .none:
                GameAPI.getGameState { data, error in
                    switch error {
                    case .none:
                        completion(data?.players, nil)
                    case .some(let error):
                        print("-> Error in request getGameState: \(error)")
                        completion(nil, error)
                    }
                }
            case .some(let error):
                print("-> Error in request postTasks: \(error)")
                completion(nil, error)
            }
        }
    }
}

// MARK: - Singleplayer
final class SingleplayerService {
    var username = ""
    var round: GameServiceModel.Round

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
    func getRound(completion: @escaping ((GameServiceModel.Round?, Error?) -> Void)) {
        completion(round, nil)
    }

    func submitAnswers(answers: AnswersDTO, completion: @escaping ((GameStateDTOPlayers?, Error?) -> Void)) {
        var score = 0.0
        answers.answers?.forEach { answer in
            guard let task = round.tasks.first(where: { $0.title == answer.title }) else { return }
            score += calculatePoints(answer: answer.coordinates!.clLocationValue, task: task.coordinates)
        }
        completion(
            .init(
                username: answers.username,
                score: Int(score.rounded()),
                isPlaying: true
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
}

extension RoundDTOCoordinates {
    var clLocationValue: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: NSDecimalNumber(decimal: lattitude!).doubleValue,
            longitude: NSDecimalNumber(decimal: longitude!).doubleValue
        )
    }

    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(longitude: Decimal(coordinate.longitude), lattitude: Decimal(coordinate.latitude))
    }
}
