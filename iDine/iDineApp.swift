//
//  iDineApp.swift
//  iDine
//
//  Created by Elliott Harris on 4/17/21.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(order)
        }
    }
}
