import MapKit
import SwiftUI

struct MKMapViewView: View {
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.4979, longitude: 19.0402),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State var longPressLocation = CGPoint.zero
    @Binding var customLocation: MapLocation
    @Binding var isNextEnabled: Bool

    var body: some View {
        GeometryReader { proxy in
            Map(coordinateRegion: $region, annotationItems: [customLocation], annotationContent: { location in
                MapMarker(coordinate: location.coordinate, tint: .red)
            })
            .gesture(LongPressGesture(minimumDuration: 0.25)
                .sequenced(before: DragGesture( minimumDistance: 0, coordinateSpace: .local))
                    .onEnded { value in
                        switch value {
                        case .second(true, let drag):
                            longPressLocation = drag?.location ?? .zero
                            customLocation = convertTap( at: longPressLocation, for: proxy.size)
                            isNextEnabled = true
                        default:
                            break
                        }
                    })
            .highPriorityGesture(DragGesture(minimumDistance: 10))
        }
    }
}

private extension MKMapViewView {
    func convertTap(at point: CGPoint, for mapSize: CGSize) -> MapLocation {
        let lat = region.center.latitude
        let lon = region.center.longitude

        let mapCenter = CGPoint(x: mapSize.width / 2, y: mapSize.height / 2)

        // X
        let xValue = (point.x - mapCenter.x) / mapCenter.x
        let xSpan = xValue * region.span.longitudeDelta / 2

        // Y
        let yValue = (point.y - mapCenter.y) / mapCenter.y
        let ySpan = yValue * region.span.latitudeDelta / 2

        return MapLocation(latitude: lat - ySpan, longitude: lon + xSpan)
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

extension MapLocation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
