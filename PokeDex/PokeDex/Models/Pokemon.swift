//
//  Pokemon.swift
//  PokeDex
//
//  Created by Bethany Wride on 10/1/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    // Make sure CodingKeys is plural and CodingKey is singular
    // I commented mine out because the keys match (sprites), see image to see codingkeys in action
//    private enum CodingKeys: String, CodingKey {
//        case abilities
//        case name
//        case id
//        case sprites
//    }
    
    let abilities: [AbilityDictionary]
    let name: String
    let id: Int
    let sprites: Sprite
}

struct AbilityDictionary: Decodable {
    let ability: Ability
   
    struct Ability: Decodable {
        let name: String
    }
}

struct Sprite: Decodable {
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
    let image: URL
}
