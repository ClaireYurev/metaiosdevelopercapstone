//
//  Home.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/26/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        
        let persistenceConstant = PersistenceController.shared
        
        let menu = Menu().environment(\.managedObjectContext, persistenceConstant.container.viewContext)
            
        let userProfile = UserProfile()
        
        TabView {
            Text("Home Page")
                .font(.title)
                .tabItem({
                    Label("Home", systemImage: "house")
                })
            
            menu.tabItem({
                Label("Menu", systemImage: "menucard")
            })
            
            userProfile.tabItem { Label("Profile", systemImage: "square.and.pencil") }
            
            // Label("Menu", systemImage: "list.dash")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
