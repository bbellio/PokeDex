//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by Bethany Wride on 10/1/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Functions
    func updateViews(pokemon: Pokemon, image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            self.pokemonAbilityLabel.text = pokemon.abilities[0].ability.name
            self.pokemonIDLabel.text = "\(pokemon.id)"
            self.spriteImageView.image = image
        }
    }
} // End of class

    // MARK: - Extension
extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.fetchPokemon(with: searchText) { (pokemon) in
            // Get image from pokemon from completion handler
            guard let pokemon = pokemon else { return }
            PokemonController.getImage(from: pokemon) { (image) in
//                guard let image = image else { return } - seems to work just fine without it?
                self.updateViews(pokemon: pokemon, image: image)
            }
        }
    }
}
