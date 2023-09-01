//
//  OnboardingPage.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/26/23.
//

import SwiftUI

let firstNameKey: String = "First Name Key"
let lastNameKey: String = "Last Name Key"
let emailKey: String = "Email Key"
let isLoggedInKey = "kIsLoggedIn"

struct OnboardingPage: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                /* THE BELOW CODE IS NOW DEPRECATED (iOS 16 & UP):
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    Text("Home")
                        .font(.title)
                    EmptyView()
                }
                */
                VStack {
                    Spacer()
                        .frame(height: 10)
                    HStack(spacing: 40) {
                        Image(systemName: "leaf")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                        Image("logo-image-littlelemon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Image(systemName: "heart")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                .padding(.bottom, 10)
                .background(.white)
                Spacer()
                    .frame(height: 100)
                Text("One of us?")
                    .font(.custom("Palatino", size: 58))
                    .foregroundColor(.mangoYellow)
                    .frame(height: 20)
                    .padding(.vertical, 10)
                Spacer()
                    .frame(height: 20)
                Text("Sign up to continue")
                    .padding()
                    .font(.custom("Palatino", size: 30))
                    .foregroundColor(.white)
                    .frame(height: 20)
                    .padding(.vertical, 10)
                Spacer()
                    .frame(height: 20)
                TextField("First Name", text: $firstName)
                    .font(.custom("Helvetica", size: 18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.horizontal, 60)
                    .padding(.vertical, 5)
                TextField("Last Name", text: $lastName)
                    .font(.custom("Helvetica", size: 18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.horizontal, 60)
                    .padding(.vertical, 5)
                TextField("Email", text: $email)
                    .font(.custom("Helvetica", size: 18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.horizontal, 60)
                    .padding(.vertical, 5)
                Spacer()
                    .frame(height: 60)
                Button {
                    if (!firstName.isEmpty || !lastName.isEmpty || !email.isEmpty && emailAddressIsValid(emailAddress: email)) {
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                        UserDefaults.standard.set(true, forKey: isLoggedInKey)
                        isLoggedIn = true
                    } else {
                        isLoggedIn = false
                    }
                } label: {
                    Text("Sign Up")
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.mangoYellow)
                            .frame(width: 276, height: 50)
                        )
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .background(Color.oliveGreen)
            .navigationDestination(isPresented: $isLoggedIn) {
                TabNavigationBar()
            }
            .onAppear() {
                if (UserDefaults.standard.bool(forKey: isLoggedInKey)) {
                    isLoggedIn = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.oliveGreen)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.oliveGreen)
    }
}

func emailAddressIsValid(emailAddress: String) -> Bool {
    let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
    return emailValidationPredicate.evaluate(with: emailAddress)
}

#Preview {
    OnboardingPage()
}
