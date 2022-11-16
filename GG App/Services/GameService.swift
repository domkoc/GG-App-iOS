//
//  GameService.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 14..
//

import CoreLocation
import SwaggerClient

protocol GameServiceProtocol {
    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void))
}

// MARK: - Multiplayer
final class MultiplayerService {}

extension MultiplayerService: GameServiceProtocol {
    func getRound(completion: @escaping ((_ data: GameServiceModel.Round?, _ error: Error?) -> Void)) {
        GameAPI.getTasks { data, error in
            switch error {
            case .none:
                completion(.init(from: data), nil)
            case .some(let error):
                print("-> Error in request getGameState: \(error)")
                completion(nil, error)
            }
        }
    }
}

// MARK: - Singleplayer
final class SingleplayerService {
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
}
