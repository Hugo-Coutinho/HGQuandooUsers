//
//  ContentView.swift
//  HGQuandooUsers
//
//  Created by Hugo Coutinho on 2024-02-29.
//

import SwiftUI
import Users

struct ContentView: View {
    @State private var isDetailViewActive = false
    
    var body: some View {
        NavigationStack {
            Group {
                UserView(isDetailViewActive: $isDetailViewActive)
            }
            .navigationDestination(isPresented: $isDetailViewActive) {
                DetailView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserModelRouter().makeModel())
        .environmentObject(DetailModelRouter().makeModel())
}
