//
//  PokemonsVC.swift
//  PokeDex
//
//  Created by Khaled Elfakharany on 4/13/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var pokemon : Pokemon!
    var pokemons = [Pokemon]()
    var audio : AVAudioPlayer!

    @IBOutlet weak var playingBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parseCSV()
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "Song", ofType: "mp3")!
        do {
            audio = try AVAudioPlayer(contentsOf: URL(string: path)!)
            audio.numberOfLoops = -1
            audio.prepareToPlay()
            audio.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func parseCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = row["id"]!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexID: pokeId)
                pokemons.append(poke)
                
            }
            
        }catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke = pokemons[indexPath.row]
            cell.configureCell(pokemon: poke)
            return cell
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    @IBAction func musicbtnPressed(_ sender: Any) {
        if audio.isPlaying {
            audio.stop()
            let image = UIImage(named: "play-button")
            playingBtn.setImage(image, for: .normal)
        }else{
            audio.play()
            let image = UIImage(named: "pause-button")
            playingBtn.setImage(image, for: .normal)
        }
    }
}

