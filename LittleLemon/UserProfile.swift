//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/29/23.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: firstNameKey)
    let lastName = UserDefaults.standard.string(forKey: lastNameKey)
    let email = UserDefaults.standard.string(forKey: emailKey)
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName ?? "We were unable to load First Name")
            Text(lastName ?? "We were unable to load Last Name")
            Text(email ?? "We were unable to load Email")
                
            Button(action: {
                UserDefaults.standard.set(false, forKey: isLoggedInKey)
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
            })
        
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
