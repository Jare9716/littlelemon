//
//  Categories.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 12/04/25.
//

import Foundation

struct Categories: Decodable {
    var id = UUID()
    var name: String
}

let categories: [Categories] = [
    Categories(name: "Starters"),
    Categories(name: "Mains"),
    Categories(name: "Desserts"),
    Categories(name: "Drinks"),
]
