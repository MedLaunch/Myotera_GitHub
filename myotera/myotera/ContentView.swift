//
//  ContentView.swift
//  myotera
//
//  Created by Mahmoud Komaiha on 2/24/21.
//

import SwiftUI
//import MovesenseApi

struct ContentView: View {
    @ObservedObject var updater = MovesenseDevices()
    func test() {
        updater.getInactiveDevicesFiltered("");
    }
    var body: some View {
        VStack {
//            Text(String(Movesense.api.getDevices().count))
            Text("Hello, world!")
                .padding()
        }.environmentObject(updater)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
