//
//  ContentView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ContentView.ViewModel())
    }
}
