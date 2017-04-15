//
//  PokeCell.swift
//  PokeDex
//
//  Created by Khaled Elfakharany on 4/15/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        
    }
    func configureCell(pokemon : Pokemon){
        pokemonName.text = pokemon.name
        pokemonImage.image = UIImage(named: pokemon.pokedexID)
    }
    
}
