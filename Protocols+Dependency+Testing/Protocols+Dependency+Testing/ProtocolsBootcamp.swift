//
//  ProtocolsBootcamp.swift
//  Protocols+Dependency+Testing
//
//  Created by Gobias LTD on 16/01/2023.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .green
    var secondary: Color = .purple
    var tertiary: Color = .white
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
    
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    
}

class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awesome"
    
    func buttonPressed() {
        print("Button was pressed")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    
    var buttonText: String = "Protocols are lame"
}



struct ProtocolsBootcamp: View {
    
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol

    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
    }
}
