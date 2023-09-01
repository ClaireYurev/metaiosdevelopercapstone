//
//  Menu.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/27/23.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func getMenuData() {
        let persistenceConstant = PersistenceController.shared
        persistenceConstant.clear()
        
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuUrl = URL(string: menuAddress)
        let request = URLRequest(url: menuUrl!)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                let utf8ResponseString = responseString!.utf8
                let jsonData = Data(utf8ResponseString)
                let decoder = JSONDecoder()
                
                if let arrayOfMenuItems = try? decoder.decode(MenuList.self, from: jsonData) {
                    for menuItem in arrayOfMenuItems.menu {
                        let newDish = Dish()
                        newDish.title = menuItem.title
                        newDish.image = menuItem.image
                        newDish.price = menuItem.price
                        newDish.category = menuItem.category
                        newDish.itemDescription = menuItem.itemDescription
                    }
                    try? viewContext.save()
                } else {
                    print(error.debugDescription.description)
                }
            } else {
                print(error.debugDescription.description)
            }
        }
        task.resume()
        
        
        /* let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data,
               let responseString = String(data: data, encoding: .utf8) {
                
                    let utf8ResponseString = responseString.utf8
                    let jsonData = Data(utf8ResponseString)
                    let decoder = JSONDecoder()
                    
                    let arrayOfMenuItems = try? decoder.decode(MenuList.self, from: jsonData)
                    
                    arrayOfMenuItems?.menu.forEach {menuItem in
                        //let newDish = Dish(context: viewContext)
                        let newDish = Dish()
                        newDish.title = menuItem.title
                        newDish.image = menuItem.image
                        newDish.price = menuItem.price
                        newDish.category = menuItem.category
                        newDish.itemDescription = menuItem.itemDescription
                    }
                    try? viewContext.save()
                }
        }*/
        
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon Restaurant")
                .font(.headline)
                .padding()
            Text("Chicago")
                .font(.subheadline)
                .padding()
            Text("Family-owned Mediterranean restaurant")
                .font(.subheadline)
                .padding()
            /* List {
                
            } */
        
            /*FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish?.title + " " + dish?.price)
                            AsyncImage(url: dish?.image)
                        }
                    }
                }
            }*/
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            //Text(dish.price ?? "unable to fetch data")
                            Text("unable to fetch data")
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
    Menu()
}
