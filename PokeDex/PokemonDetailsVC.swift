//
//  PokemonDetailsVC.swift
//  PokeDex
//
//  Created by Khaled Elfakharany on 4/15/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    var sentPokemon : Pokemon!
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonBaseAttack: UILabel!
    @IBOutlet weak var nextEvoLabel: UILabel!
    @IBOutlet weak var currentPokemonImage: UIImageView!
    @IBOutlet weak var nextPokemonEvo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentPokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI(){
        pokemonNameLbl.text = sentPokemon.name
        pokemonImage.image = UIImage(named: sentPokemon.pokedexID)
        pokemonDescription.text = sentPokemon.description
        pokemonType.text = sentPokemon.type
        pokemonDefense.text = sentPokemon.defense
        pokemonHeight.text = sentPokemon.height
        pokemonWeight.text = sentPokemon.weight
        pokemonBaseAttack.text = sentPokemon.attack
        currentPokemonImage.image = UIImage(named: sentPokemon.pokedexID)
        pokedexID.text = sentPokemon.pokedexID
        if sentPokemon.nextEvolutionId == "" {
            
            nextEvoLabel.text = "No Evolutions"
            nextPokemonEvo.isHidden = true
            
        } else {
            
            nextPokemonEvo.isHidden = false
            nextPokemonEvo.image = UIImage(named: sentPokemon.nextEvolutionId)
            let str = "Next Evolution: \(sentPokemon.nextEvolutionName) - LVL \(sentPokemon.nextEvolutionLevel)"
            nextEvoLabel.text = str
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
