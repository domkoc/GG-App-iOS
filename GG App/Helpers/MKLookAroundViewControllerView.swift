import MapKit
import SwiftUI

struct MKLookAroundViewControllerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MKLookAroundViewController

    var coordinate: CLLocationCoordinate2D

    func makeUIViewController(context: Context) -> MKLookAroundViewController {
        let vc = MKLookAroundViewController()
        vc.showsRoadLabels = false
        vc.isNavigationEnabled = true
        return vc
    }

    func updateUIViewController(_ vc: MKLookAroundViewController, context: Context) {
        Task {
            vc.scene = await getScene(location: coordinate)
        }
    }

    func getScene(location: CLLocationCoordinate2D?) async -> MKLookAroundScene? {
        if let latitude = location?.latitude, let longitude = location?.longitude {
            let sceneRequest = MKLookAroundSceneRequest(coordinate: .init(latitude: latitude, longitude: longitude))

            do {
                return try await sceneRequest.scene
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }

//    func makeUIView(context: Self.Context) -> MKLookAroundViewController {
//        let view = MKLookAroundViewController()
//        return view
//    }
//
//    func updateUIView(_ mapView: MKLookAroundViewController, context: Context) {
//        mapView.moveNearCoordinate(coordinate)
//    }
}
