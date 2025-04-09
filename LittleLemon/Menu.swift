//
//  Menu.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 7/04/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let serverURLString =
        "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        let url = URL(string: serverURLString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in
            
            if let data = data {
                let decoder = JSONDecoder()
                
                if let menuList = try? decoder.decode(MenuList.self, from: data)
                {
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                    }
                    
                    try? viewContext.save().self
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("An app for managing ordering your favorite food")
            
            FetchedObjects { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title!) - $\(dish.price!)")
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
        }
        .onAppear { getMenuData() }
    }
}

#Preview {
    Menu()
}
