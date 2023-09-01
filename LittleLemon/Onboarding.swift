//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/26/23.
//

import SwiftUI

let firstNameKey: String = "First Name Key"
let lastNameKey: String = "Last Name Key"
let emailKey: String = "Email Key"

let isLoggedInKey = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                /* THE BELOW CODE IS NOW DEPRECATED:
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    Text("Home")
                        .font(.title)
                    EmptyView()
                }
                */
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Onboarding Screen!")
                    .padding()
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button {
                    if (!firstName.isEmpty || !lastName.isEmpty || !email.isEmpty && emailAddressIsValid(emailAddress: email)) {
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                        UserDefaults.standard.set(true, forKey: isLoggedInKey)
                
                        isLoggedIn = true
                        
                        // Navigate to the Home Screen
                        
                    } else {
                        isLoggedIn = false
                    }
                } label: {
                    Text("Register")
                }
                
            } // end of VStack
            .padding()
            .navigationTitle("Home")
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear() {
                if (UserDefaults.standard.bool(forKey: isLoggedInKey)) {
                    isLoggedIn = true
                }
            }
        } // end of NavigationStack
    } // end of var body: some View
} // end of Struct Onboarding: View

func emailAddressIsValid(emailAddress: String) -> Bool {
    let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
    return emailValidationPredicate.evaluate(with: emailAddress)
}

#Preview {
    Onboarding()
}
