//
//  GameServiceModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 14..
//

import CoreLocation
import SwaggerClient

// MARK: - GameServiceModel
struct GameServiceModel { }

// MARK: - GameServiceModel.Round
extension GameServiceModel {
    struct Round {
        var tasks: [GameServiceModel.Task]

        init(tasks: [GameServiceModel.Task]) {
            self.tasks = tasks
        }

        init(from dto: RoundDTO?) {
            guard
                let dto = dto,
                let dtoTasks = dto.tasks else {
                print("-> Error: Can't deserialize RoundDTO")
                self.tasks = []
                return
            }
            self.tasks = dtoTasks.map { .init(from: $0) }
        }
    }
}

// MARK: - GameServiceModel.Task
extension GameServiceModel {
    struct Task {
        public var title: String
        public var coordinates: CLLocationCoordinate2D
        public var seconds: Double

        init(title: String, coordinates: CLLocationCoordinate2D, seconds: Double) {
            self.title = title
            self.coordinates = coordinates
            self.seconds = seconds
        }

        init(from dto: RoundDTOTasks) {
            guard
                let dtoTitle = dto.title,
                let dtoCoordinates = dto.coordinates,
                let dtoLattitude = dtoCoordinates.lattitude, // FIXME: remove swap on backend fix
                let dtoLongitude = dtoCoordinates.longitude, // FIXME: remove swap on backend fix
                let dtoSeconds = dto.seconds
            else {
                print("-> Error: Can't deserialize RoundDTOTasks")
                self.title = .init()
                self.coordinates = .init()
                self.seconds = .init()
                return
            }
            self.title = dtoTitle
            self.coordinates = CLLocationCoordinate2D(
                latitude: NSDecimalNumber(decimal: dtoLattitude).doubleValue,
                longitude: NSDecimalNumber(decimal: dtoLongitude).doubleValue
            )
            self.seconds = NSDecimalNumber(decimal: dtoSeconds).doubleValue
        }
    }
}
