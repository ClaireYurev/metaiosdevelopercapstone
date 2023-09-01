//
//  UserProfilePage.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/29/23.
//

import SwiftUI

struct UserProfilePage: View {
    
    @Environment(\.presentationMode) var presentation
    let firstName = UserDefaults.standard.string(forKey: firstNameKey)
    let lastName = UserDefaults.standard.string(forKey: lastNameKey)
    let email = UserDefaults.standard.string(forKey: emailKey)
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            Text("Personal Information")
                .font(.title)
            Spacer()
                .frame(height: 50)
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
                .frame(height: 50)
            Text(firstName ?? "Sorry, unable to load First Name")
                .bold()
            Text(lastName ?? "Sorry, unable to load Last Name")
                .bold()
            Text(email ?? "Sorry, unable to load Email")
                .italic()
            Spacer()
                .frame(height: 50)
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
    UserProfilePage()
}
