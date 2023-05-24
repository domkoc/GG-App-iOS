//
//  MapView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import SwiftUI

struct MapView: View {
    typealias Txt = Strings.MapView

    @Environment(\.isUsingGoogleMaps) var isUsingGoogleMaps
    @StateObject var vm: ViewModel

    var body: some View {
        VStack {
            if isUsingGoogleMaps {
                GoogleMapsView(
                    marker: $vm.marker,
                    isNextEnabled: $vm.isButtonEnabled
                )
            } else {
                MKMapViewView(
                    customLocation: $vm.mkMapLocation,
                    isNextEnabled: $vm.isButtonEnabled
                )
            }
            Button(Txt.Buttons.done) {
                print($vm.marker.position)
                vm.doneSelecting()
            }
            .disabled(!vm.isButtonEnabled)
        }
    }
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.mapView(completion: { _ in })
    }
}
#endif
