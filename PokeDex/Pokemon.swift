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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    var pokedexID : String {
        return _pokedexID
    }
    
    init(name : String , pokedexID : String) {
        _name = name
        _pokedexID = pokedexID
        _pokemonURL = "http://pokeapi.co/api/v1/pokemon/\(self._pokedexID!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping ()->()) {
        Alamofire.request(_pokemonURL).responseJSON{ response in
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String,AnyObject>] {
                    if let resource_uri = descriptions[0]["resource_uri"] as? String {
                        let url = "http://pokeapi.co/\(resource_uri)"
                        Alamofire.request(url).responseJSON{ response in
                            let result = response.result
                            if let dict = result.value as? Dictionary<String,AnyObject> {
                                if let description = dict["description"] as? String{
                                    self._description = description
                                }
                            }
                            completed()
                        }
                    }
                }
                if let type = dict["types"] as? [Dictionary<String,AnyObject>], type.count > 0 {
                    if let name = type[0]["name"] as? String {
                        self._type = name.capitalized
                    }
                    if type.count > 1 {
                        for x in 1..<type.count{
                            if let name = type[x]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                } else {
                                    
                                    self._nextEvolutionLevel = ""
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
            completed()
        }
    }
    
}
