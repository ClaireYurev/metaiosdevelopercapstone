//
//  HomePage.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/27/23.
//

import Foundation
import CoreData
import SwiftUI

struct HomePage: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuUrl = URL(string: menuAddress)!
        let request = URLRequest(url: menuUrl)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let liveOnlineMenuData = data {
                let responseString = String(data: liveOnlineMenuData, encoding: .utf8)
                let utf8ResponseString = responseString!.utf8
                let jsonData = Data(utf8ResponseString)
                let decoder = JSONDecoder()
                let arrayOfMenuItems = try! decoder.decode(MenuList.self, from: jsonData)
                for menuItem in arrayOfMenuItems.menu {
                    let newDish = Dish(context: viewContext)
                    newDish.title = menuItem.title
                    newDish.image = menuItem.image
                    newDish.price = menuItem.price
                    newDish.category = menuItem.category
                    newDish.itemDescription = menuItem.description
                }
                try? viewContext.save()
            } else {
                print(error.debugDescription.description)
                let offlineUtf8ResponseString = OfflineData().offlineMenuString.utf8
                let offlineJsonData = Data(offlineUtf8ResponseString)
                let offlineDecoder = JSONDecoder()
                if let offlineArrayOfMenuItems = try? offlineDecoder.decode(MenuList.self, from: offlineJsonData) {
                    for menuItem in offlineArrayOfMenuItems.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = menuItem.title
                        newDish.image = menuItem.image
                        newDish.price = menuItem.price
                        newDish.category = menuItem.category
                        newDish.itemDescription = menuItem.description
                    }
                } else {
                    let newDish = Dish(context: viewContext)
                    newDish.title = "Offline menu failed to load."
                    newDish.image = ""
                    newDish.price = "0"
                    newDish.category = ""
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    func buildMenuSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildMenuPredicate() -> NSPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        return search
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack {
                    HStack(spacing: 40) {
                        Image(systemName: "leaf")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                        Image("logo-image-littlelemon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Image("profile-image-placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                .padding(.bottom, 10)
                .background(.white)
                Text("Little Lemon")
                    .font(.custom("Palatino", size: 42))
                    .foregroundColor(.mangoYellow)
                    .padding(.leading)
                Text("Los Angeles")
                    .font(.custom("Palatino", size: 32))
                    .foregroundColor(.white)
                    .padding(.leading)
                HStack() {
                    Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.custom("Helvetica", size: 16))
                        .foregroundColor(.white)
                        .lineSpacing(4)
                        .padding()
                    AsyncImage(url: URL(string: "https://github.com/ClaireYurev/metaiosdevelopercapstone/blob/main/lobsterrolls.png?raw=true")) { phase in
                        if let image = phase.image {
                            image.resizable() // Display the loaded image
                        } else if phase.error != nil {
                            Color.red // Indicate an error
                        } else {
                            ProgressView() // Loading animation
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .frame(width: 140, height: 140)
                    //.background(Color.green)
                    .padding(10)
                }
                .padding(4)
                .frame(maxHeight: 160)
                
                TextField("🔍 Search menu", text: $searchText)
                    .font(.custom("Helvetica", size: 18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding()
            }
            .background(Color.oliveGreen)
            
            FetchedObjects(predicate: buildMenuPredicate(), sortDescriptors: buildMenuSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink {
                            VStack {
                                Text("\(dish.title ?? "")")
                                    .font(.largeTitle)
                                    .padding()
                                Text("Category: \(dish.category?.capitalized ?? "")")
                                    .font(.title3)
                                    .italic()
                                    .padding()
                                Text("\(dish.itemDescription ?? "")")
                                    .font(.body)
                                    .padding()
                                Text("Dish price: $\(dish.price ?? "")")
                                    .bold()
                                AsyncImage(url: URL(string: dish.image!)) { phase in
                                    if let image = phase.image {
                                        image.resizable() // Display the loaded image
                                    } else if phase.error != nil {
                                        Color.red // Indicate an error
                                    } else {
                                        ProgressView() // Loading animation
                                    }
                                }
                                .aspectRatio(contentMode: .fit)
                            }
                        } label: {
                            HStack {
                                Text("\(dish.title ?? "")'s price is: $\(dish.price ?? "")")
                                AsyncImage(url: URL(string: dish.image!)) { phase in
                                    if let image = phase.image {
                                        image.resizable() // Display the loaded image
                                    } else if phase.error != nil {
                                        Color.red // Indicate an error
                                    } else {
                                        ProgressView() // Loading animation
                                    }
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
}

#Preview {
    HomePage()
}
