//
//  ContentView.swift
//  Protocols+Dependency+Testing
//
//  Created by Gobias LTD on 16/01/2023.
//

import SwiftUI



struct ContentView: View {
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
        ContentView()
    }
}
