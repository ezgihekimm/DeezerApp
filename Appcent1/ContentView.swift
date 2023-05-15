//
//  ContentView.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Label("Default", systemImage: "heart")
            Label("Fill", systemImage: "heart.fill")
            Label("Circle", systemImage: "heart.circle")
            Label("Circle Fill", systemImage: "heart.circle.fill")
        }
    }
}
