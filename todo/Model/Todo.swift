//
//  Todo.swift
//  todo
//
//  Created by Muhaimin on 22/7/20.
//  Copyright © 2020 Muhaimin. All rights reserved.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
}
struct Todo: Codable {
    let item: String
    let priority: Int
}
