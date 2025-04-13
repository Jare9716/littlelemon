//
//  Menu.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 7/04/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var searchText = ""

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
                        dish.information = menuItem.description
                    }
                    try? viewContext.save().self
                }
            }
        }
        task.resume()
    }

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare)
            )
        ]
    }

    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Image("Logo")
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding([.trailing])
            VStack(alignment: .leading) {
                Text("Little lemon")
                    .font(.system(size: 56))
                    .fontDesign(.serif)
                    .foregroundStyle(
                        Color(
                            red: 244 / 255,
                            green: 206 / 255,
                            blue: 20 / 255
                        )
                    )
                Text("Chicago")
                    .font(.title)
                    .fontDesign(.serif)
                    .foregroundStyle(.white)
                HStack {
                    Text(
                        "We are a family owned Mediterranean restaurant, focused on traditional recepies served with a modern twist."
                    )
                    .font(.body)
                    .fontDesign(.serif)
                    .foregroundStyle(.white)
                    Image("Hero-image")
                        .resizable()
                        .frame(width: 100, height: 150)
                        .cornerRadius(16)
                }
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
            )
            VStack(alignment: .leading) {
                Text("ORDER FOR DELIVERY!")
                    .font(.title3)
                    .fontWeight(.semibold)

                HStack {
                    ForEach(categories, id: \.id) { category in
                        Button {
                        } label: {
                            Text(category.name)
                                .fontWeight(.semibold)
                                .foregroundStyle(
                                    Color(
                                        red: 73 / 255,
                                        green: 94 / 255,
                                        blue: 87 / 255
                                    )
                                )
                        }
                        .buttonStyle(.bordered)
                        Spacer()

                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)

            }
            .padding([.leading, .top])
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(dish.title!)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text(dish.information!)
                                    .font(.caption)
                                    .foregroundStyle(
                                        Color(
                                            red: 73 / 255,
                                            green: 94 / 255,
                                            blue: 87 / 255
                                        )
                                    )
                                Text("$\(dish.price!)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(
                                        Color(
                                            red: 73 / 255,
                                            green: 94 / 255,
                                            blue: 87 / 255
                                        )
                                    )
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) {
                                image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
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
