//
//  UnitTestingBootcampView.swift
//  Protocols+Dependency+Testing
//
//  Created by Gobias LTD on 17/01/2023.
//

/*
 1. Unit Tests
 - Test the business logic
 
 2. UI Tests
 - Test the UI of your app
 */

import SwiftUI



struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
        
    }
    
    var body: some View {
       // Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcampView(isPremium: true)
    }
}
