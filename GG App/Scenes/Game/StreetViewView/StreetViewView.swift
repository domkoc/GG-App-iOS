//
//  StreetViewView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import GoogleMaps
import SwiftUI

struct StreetViewView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        GoogleStreetViewView(coordinate: vm.coordinates)
            .ignoresSafeArea()
    }
}

#if DEBUG
struct StreetViewView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.streetViewView()
    }
}
#endif
