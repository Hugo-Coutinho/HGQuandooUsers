//
//  HGQuandooUsersApp.swift
//  HGQuandooUsers
//
//  Created by Hugo Coutinho on 2024-02-29.
//

import SwiftUI
import Users

@main
struct HGQuandooUsersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserModelRouter().makeModel())
                .environmentObject(DetailModelRouter().makeModel())
        }
    }
}
