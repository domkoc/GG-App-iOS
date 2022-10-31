//
//  MapView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import SwiftUI

struct MapView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        VStack {
            GoogleMapsView(marker: $vm.marker)
        }
        Button("Done") {
            print($vm.marker.position)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.mapView()
    }
}
