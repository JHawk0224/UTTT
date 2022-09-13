//
//  Game.swift
//  firsttime
//
//  Created by iD Student on 7/17/17.
//  Copyright © 2017 iD Student. All rights reserved.
//
import Foundation
import UIKit
class Game: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet var instructions : UILabel!
    @IBOutlet var coin : UILabel!
    @IBOutlet var buttons1 : [UIButton]!
    @IBOutlet var buttons2 : [UIButton]!
    @IBOutlet var buttons3 : [UIButton]!
    @IBOutlet var buttons4 : [UIButton]!
    @IBOutlet var buttons5 : [UIButton]!
    @IBOutlet var buttons6 : [UIButton]!
    @IBOutlet var buttons7 : [UIButton]!
    @IBOutlet var buttons8 : [UIButton]!
    @IBOutlet var buttons9 : [UIButton]!
    @IBOutlet var buttons : [UIButton]!
    var buttonsArray : [[UIButton]]!
    var turn : Int = 1
    var nextBoard : Int = 5
    var defaultColor : UIColor!
    var boardChoice = true
    var win : String = ""
    var characters : [String] = ["X", "O"]
    var photos : [String] = ["none", "none"]
    static var coins : Int = 0
    @IBAction func changeName(sender : UIButton) {
        saveData(value: "yes", key: "savedData?")
        saveData(value: "false", key: "boardChoice")
        if boardChoice == true {
            ifBoardChoice(tag: sender.tag)
        } else {
            var go = true
            if let x = sender.currentTitle {
                if x == characters[0] || x == characters[1] {
                    go = false
                }
            }
            if sender.tag / 10 == nextBoard {
                if go == true {
                    if turn == 1 {
                        sender.setTitle(characters[0], for: .normal)
                        saveData(value: characters[0], key: String(sender.tag))
                        turn = 2
                        saveData(value: "2", key: "turn")
                        instructions.text = "Player 2 please choose a spot."
                        saveData(value: "Player 2 please choose a spot.", key: "instructions")
                        putImage(sender: sender, turn: "X")
                    } else {
                        sender.setTitle(characters[1], for: .normal)
                        saveData(value: characters[1], key: String(sender.tag))
                        turn = 1
                        saveData(value: "1", key: "turn")
                        instructions.text = "Player 1 please choose a spot."
                        saveData(value: "Player 1 please choose a spot.", key: "instructions")
                        putImage(sender: sender, turn: "O")
                    }
                    buttons[nextBoard - 1].backgroundColor = defaultColor
                    nextBoard = sender.tag % 10
                    saveData(value: String(nextBoard), key: "nextBoard")
                    checkWin()
                    if win == characters[0] {
                        if instructions.text != "Player 1 Wins!" {
                            Game.coins += 25
                            if Game.coins > 9999 {
                                Game.coins = 9999
                            }
                            coin.text = String(Game.coins)
                            saveData(value: String(Game.coins), key: "coins")
                        }
                        instructions.text = "Player 1 Wins!"
                        saveData(value: "Player 1 Wins!", key: "instructions")
                    } else if win == characters[1] {
                        if instructions.text != "Player 2 Wins!" {
                            Game.coins += 25
                            if Game.coins > 9999 {
                                Game.coins = 9999
                            }
                            coin.text = String(Game.coins)
                            saveData(value: String(Game.coins), key: "coins")
                        }
                        instructions.text = "Player 2 Wins!"
                        saveData(value: "Player 2 Wins!", key: "instructions")
                    } else {
                        settingColor()
                    }
                }
            }
        }
    }
    func settingColor() {
        var test = true
        if let x = buttons[nextBoard - 1].currentTitle {
            test = false
            if x != characters[0] && x != characters[1] {
                buttons[nextBoard - 1].backgroundColor = UIColor.yellow
            } else {
                if turn == 1 {
                    instructions.text = "Player 1 please choose a board."
                    saveData(value: "Player 1 please choose a board.", key: "instructions")
                } else {
                    instructions.text = "Player 2 please choose a board."
                    saveData(value: "Player 2 please choose a board.", key: "instructions")
                }
                boardChoice = true
                saveData(value: "true", key: "boardChoice")
            }
        }
        if test == true {
            buttons[nextBoard - 1].backgroundColor = UIColor.yellow
        }
    }
    func ifBoardChoice(tag : Int) {
        nextBoard = tag / 10
        saveData(value: String(nextBoard), key: "nextBoard")
        buttons[nextBoard - 1].backgroundColor = UIColor.yellow
        if turn == 1 {
            instructions.text = "Player 1 please choose a spot."
            saveData(value: "Player 1 please choose a spot.", key: "instructions")
        } else {
            instructions.text = "Player 2 please choose a spot."
            saveData(value: "Player 2 please choose a spot.", key: "instructions")
        }
        boardChoice = false
    }
    func checkWin() {
        for b in 0 ..< 9 {
            for a in 0 ... 2 {
                if let x = buttonsArray[b][a * 3].currentTitle, let y = buttonsArray[b][(a * 3) + 1].currentTitle, let z = buttonsArray[b][(a * 3) + 2].currentTitle {
                    if x == y && x == z && (x == characters[1] || x == characters[0]) {
                        buttons[b].setTitle(x, for: .normal)
                        saveData(value: x, key: String(buttons[b].tag))
                        self.view.bringSubview(toFront: buttons[b])
                        putImage(sender: buttons[b], turn: x)
                    }
                }
                if let x = buttonsArray[b][a].currentTitle, let y = buttonsArray[b][a + 3].currentTitle, let z = buttonsArray[b][a + 6].currentTitle {
                    if x == y && x == z && (x == characters[1] || x == characters[0]) {
                        buttons[b].setTitle(x, for: .normal)
                        saveData(value: x, key: String(buttons[b].tag))
                        self.view.bringSubview(toFront: buttons[b])
                        putImage(sender: buttons[b], turn: x)
                    }
                }
            }
            if let x = buttonsArray[b][0].currentTitle, let y = buttonsArray[b][4].currentTitle, let z = buttonsArray[b][8].currentTitle {
                if x == y && x == z && (x == characters[1] || x == characters[0]) {
                    buttons[b].setTitle(x, for: .normal)
                    saveData(value: x, key: String(buttons[b].tag))
                    self.view.bringSubview(toFront: buttons[b])
                    putImage(sender: buttons[b], turn: x)
                }
            }
            if let x = buttonsArray[b][2].currentTitle, let y = buttonsArray[b][4].currentTitle, let z = buttonsArray[b][6].currentTitle {
                if x == y && x == z && (x == characters[1] || x == characters[0]) {
                    buttons[b].setTitle(x, for: .normal)
                    saveData(value: x, key: String(buttons[b].tag))
                    self.view.bringSubview(toFront: buttons[b])
                    putImage(sender: buttons[b], turn: x)
                }
            }
        }
        for a in 0 ... 2 {
            if let x = buttons[a * 3].currentTitle, let y = buttons[(a * 3) + 1].currentTitle, let z = buttons[(a * 3) + 2].currentTitle {
                if x == y && x == z && (x == characters[1] || x == characters[0]) {
                    win = x
                }
            }
            if let x = buttons[a].currentTitle, let y = buttons[a + 3].currentTitle, let z = buttons[a + 6].currentTitle {
                if x == y && x == z && (x == characters[1] || x == characters[0]) {
                    win = x
                }
            }
        }
        if let x = buttons[0].currentTitle, let y = buttons[4].currentTitle, let z = buttons[8].currentTitle {
            if x == y && x == z && (x == characters[1] || x == characters[0]) {
                win = x
            }
        }
        if let x = buttons[2].currentTitle, let y = buttons[4].currentTitle, let z = buttons[6].currentTitle {
            if x == y && x == z && (x == characters[1] || x == characters[0]) {
                win = x
            }
        }
    }
    func putImage(sender : UIButton, turn : String) {
        var oneOrTwo = 0
        if turn == "X" || turn == "L" {
            oneOrTwo = 1
        } else if turn == "O" || turn == "D" {
            oneOrTwo = 2
        }
        if photos[0] != "none" && oneOrTwo == 1 {
            sender.setImage(UIImage(named: photos[0])?.withRenderingMode(.alwaysOriginal), for: .normal)
            sender.setImage(UIImage(named: photos[0])?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        } else if photos[1] != "none" && oneOrTwo == 2 {
            sender.setImage(UIImage(named: photos[1])?.withRenderingMode(.alwaysOriginal), for: .normal)
            sender.setImage(UIImage(named: photos[1])?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        } else {
            sender.setImage(nil, for: .normal)
            sender.setImage(nil, for: .highlighted)
        }
    }
    func loadData() {
        characters[0] = defaults.string(forKey: "character1")!
        characters[1] = defaults.string(forKey: "character2")!
        photos[0] = defaults.string(forKey: "x photo")!
        photos[1] = defaults.string(forKey: "y photo")!
        for x in 0 ... 8 {
            for y in 0 ... 8 {
                let z = y + 1 + ((x + 1) * 10)
                if let stringValue = defaults.string(forKey: String(z)) {
                    buttonsArray[x][y].setTitle(stringValue, for: .normal)
                }
                if buttonsArray[x][y].currentTitle == "X" || buttonsArray[x][y].currentTitle == "L" {
                    buttonsArray[x][y].setTitle(characters[0], for: .normal)
                    saveData(value: "yes", key: "savedData?")
                    putImage(sender: buttonsArray[x][y], turn: "X")
                } else if buttonsArray[x][y].currentTitle == "O" || buttonsArray[x][y].currentTitle == "D" {
                    buttonsArray[x][y].setTitle(characters[1], for: .normal)
                    saveData(value: "yes", key: "savedData?")
                    putImage(sender: buttonsArray[x][y], turn: "O")
                }
            }
            if let stringValue = defaults.string(forKey: String((x + 1) * 10)) {
                buttons[x].setTitle(stringValue, for: .normal)
                if stringValue == characters[0] || stringValue == characters[1] {
                    self.view.bringSubview(toFront: buttons[x])
                }
            }
            if buttons[x].currentTitle == "X" || buttons[x].currentTitle == "L" {
                buttons[x].setTitle(characters[0], for: .normal)
                saveData(value: "yes", key: "savedData?")
                self.view.bringSubview(toFront: buttons[x])
                putImage(sender: buttons[x], turn: "X")
            } else if buttons[x].currentTitle == "O" || buttons[x].currentTitle == "D" {
                buttons[x].setTitle(characters[1], for: .normal)
                saveData(value: "yes", key: "savedData?")
                self.view.bringSubview(toFront: buttons[x])
                putImage(sender: buttons[x], turn: "O")
            }
        }
        if let top = defaults.string(forKey: "instructions") {
            instructions.text = top
        }
        if let turnNum = defaults.string(forKey: "turn") {
            turn = Int(turnNum)!
        }
        if let board = defaults.string(forKey: "nextBoard") {
            nextBoard = Int(board)!
        }
        if let choice = defaults.string(forKey: "boardChoice") {
            if choice == "true" {
                boardChoice = true
            } else if choice == "false" {
                boardChoice = false
            }
        }
        defaultColor = buttons[0].backgroundColor
        if buttons[nextBoard - 1].currentTitle != characters[0] && buttons[nextBoard - 1].currentTitle != characters[1] {
            if let newGame = defaults.string(forKey: "newGame?") {
                if newGame == "no" {
                    buttons[nextBoard - 1].backgroundColor = UIColor.yellow
                }
            }
        }
        saveData(value: "no", key: "newGame?")
    }
    override func viewDidLoad() {
        coin.text = String(Game.coins)
        saveData(value: "no", key: "savedData?")
        buttonsArray = [buttons1, buttons2, buttons3, buttons4, buttons5, buttons6, buttons7, buttons8, buttons9]
        super.viewDidLoad()
        for x in 0 ... 8 {
            for y in 0 ... 8 {
                buttonsArray[x][y].tag = y + 1 + ((x + 1) * 10)
            }
            buttons[x].tag = (x + 1) * 10
        }
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func saveData(value : String, key : String) {
        defaults.set(value, forKey: key)
    }
}
