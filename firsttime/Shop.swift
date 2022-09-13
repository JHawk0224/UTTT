//
//  Shop.swift
//  firsttime
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 iD Student. All rights reserved.
//
import Foundation
import UIKit
class Shop: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet var coin : UILabel!
    @IBOutlet var ErrorMessage : UILabel!
    @IBOutlet var buttons : [UIButton]!
    @IBOutlet var coins : [UIImageView]!
    @IBAction func changeName(sender : UIButton) {
        var goOn = false
        if let string = defaults.string(forKey: String(sender.tag)) {
            if string == "unowned" {
                if Game.coins >= Int(sender.currentTitle!)! {
                    Game.coins -= Int(sender.currentTitle!)!
                    coin.text = String(Game.coins)
                    saveData(value: String(Game.coins), key: "coins")
                    coins[sender.tag - 1].alpha = 0.0
                    saveData(value: "invisible", key: "Coins: " + String(sender.tag - 1))
                    sender.titleEdgeInsets = UIEdgeInsetsMake(65.0, 0.0, 0.0, 0.0)
                    goOn = true
                } else {
                    ErrorMessage.alpha = 1.0
                }
            }
            if string == "Owned!" || goOn == true {
                ErrorMessage.alpha = 0.0
                for x in 0 ... 8 {
                    if let string = defaults.string(forKey: String(x)) {
                        if string == "Equipped!" {
                            buttons[x].setBackgroundImage(UIImage(named: "OwnedTile")?.withRenderingMode(.alwaysOriginal), for: .normal)
                            buttons[x].setBackgroundImage(UIImage(named: "OwnedTile")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
                            saveData(value: "Owned!", key: String(x))
                            buttons[x].setTitle("Owned!", for: .normal)
                        }
                    }
                }
                sender.setBackgroundImage(UIImage(named: "EquipedTile")?.withRenderingMode(.alwaysOriginal), for: .normal)
                sender.setBackgroundImage(UIImage(named: "EquipedTile")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
                saveData(value: "Equipped!", key: String(sender.tag))
                sender.setTitle("Equipped!", for: .normal)
            } else if string == "Equipped!" {
                ErrorMessage.alpha = 0.0
            }
            if let string = defaults.string(forKey: String(sender.tag)) {
                if string == "Equipped!" {
                    if sender.tag == 0 {
                        saveData(value: "X", key: "character1")
                        saveData(value: "O", key: "character2")
                        saveData(value: "none", key: "x photo")
                        saveData(value: "none", key: "y photo")
                    } else if sender.tag == 1 {
                        saveData(value: "L", key: "character1")
                        saveData(value: "O", key: "character2")
                        saveData(value: "none", key: "x photo")
                        saveData(value: "none", key: "y photo")
                    } else if sender.tag == 2 {
                        saveData(value: "X", key: "character1")
                        saveData(value: "D", key: "character2")
                        saveData(value: "none", key: "x photo")
                        saveData(value: "none", key: "y photo")
                    } else if sender.tag == 3 {
                        saveData(value: "X.png", key: "x photo")
                        saveData(value: "O.png", key: "y photo")
                    } else if sender.tag == 4 {
                        saveData(value: "L.png", key: "x photo")
                        saveData(value: "O.png", key: "y photo")
                    } else if sender.tag == 5 {
                        saveData(value: "X.png", key: "x photo")
                        saveData(value: "D.png", key: "y photo")
                    } else if sender.tag == 6 {
                        saveData(value: "Xbox.png", key: "x photo")
                        saveData(value: "PS4.png", key: "y photo")
                    } else if sender.tag == 7 {
                        saveData(value: "Apple.png", key: "x photo")
                        saveData(value: "Windows.png", key: "y photo")
                    } else if sender.tag == 8 {
                        saveData(value: "HillaryClinton.png", key: "x photo")
                        saveData(value: "DonaldTrump.png", key: "y photo")
                    }
                }
            }
        }
    }
    func saveData(value : String, key : String) {
        defaults.set(value, forKey: key)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.string(forKey: "test") == nil {
            saveData(value: "Equipped!", key: "0")
            for x in 1 ... 8 {
                saveData(value: "unowned", key: String(x))
            }
        }
        saveData(value: "test", key: "test")
        coin.text = String(Game.coins)
        for x in 0 ... 8 {
            if let string = defaults.string(forKey: "Coins: " + String(x)) {
                if string == "invisible" {
                    coins[x].alpha = 0.0
                }
            }
            buttons[x].tag = x
            if let string = defaults.string(forKey: String(x)) {
                if string == "Owned!" {
                    buttons[x].setBackgroundImage(UIImage(named: "OwnedTile")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    buttons[x].setBackgroundImage(UIImage(named: "OwnedTile")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
                    buttons[x].setTitle("Owned!", for: .normal)
                    buttons[x].titleEdgeInsets = UIEdgeInsetsMake(65.0, 0.0, 0.0, 0.0)
                } else if string == "Equipped!" {
                    buttons[x].setBackgroundImage(UIImage(named: "EquipedTile")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    buttons[x].setBackgroundImage(UIImage(named: "EquipedTile")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
                    buttons[x].setTitle("Equipped!", for: .normal)
                    buttons[x].titleEdgeInsets = UIEdgeInsetsMake(65.0, 0.0, 0.0, 0.0)
                }
            }
        }
    }
}
