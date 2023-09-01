//
//  TabNavigationBar.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/26/23.
//

import SwiftUI

struct TabNavigationBar: View {
    
    var body: some View {
        
        let persistenceConstant = PersistenceController.shared
        
        let home = HomePage()
            .environment(\.managedObjectContext, persistenceConstant.container.viewContext)
        
        let menu = MenuPage()
            .environment(\.managedObjectContext, persistenceConstant.container.viewContext)
            
        let userProfile = UserProfilePage()
        
        TabView {
            home.tabItem({
                // Routes to HomePage()
                Label("Home", systemImage: "house")
            })
            menu.tabItem({
                // Routes to MenuPage()
                Label("Menu", systemImage: "menucard")
            })
            userProfile.tabItem { Label("Profile", systemImage:
                // Routes to UserProfilePage()
                "square.and.pencil") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabNavigationBar()
}
