//
//  PokemonController.swift
//  PokeDex
//
//  Created by Bethany Wride on 10/1/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    // Make sure to put the baseURL outside of the function for assessment
    // Takes in another function, completion, as a parameter - the completion function takes in a pokemon or returns void
    static func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        // Create baseURL constant assigned to the API base URL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/") else { return }
        // Add components
        let pokemonComponent = baseURL.appendingPathComponent("pokemon")
        let finalURL = pokemonComponent.appendingPathComponent(searchTerm)
        print(finalURL)
        // Perform dataTask - URLSession function takes in a URL, navigates to URL, and pulls the data returned to us from URL
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error performing dataTask: \(error.localizedDescription) \n---\n \(error)")
                return
            }
            
            if let data = data {
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(pokemon)
                } catch {
                    print("Error decoding data")
                    completion(nil)
                    return
                }
            }
        } .resume()
    }
    
    static func getImage(from pokemon: Pokemon, completion: @escaping (UIImage) -> Void) {
        let finalURL = pokemon.sprites.image
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                 print("Error retrieving image : \(error.localizedDescription) \n---\n \(error)")
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            completion(image)
        }
        dataTask.resume()
    }
} // End of class
