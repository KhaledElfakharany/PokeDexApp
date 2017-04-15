//
//  Pokemon.swift
//  PokeDex
//
//  Created by Khaled Elfakharany on 4/15/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Pokemon {
    private var _name : String!
    private var _pokedexID : String!
    
    var name: String {
        return _name
    }
    var pokedexID : String {
        return _pokedexID
    }
    
    init(name : String , pokedexID : String) {
        _name = name
        _pokedexID = pokedexID
    }
    
}
