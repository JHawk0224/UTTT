//
//  Menu.swift
//  firsttime
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 iD Student. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
class Menu: UIViewController {
    static var player: AVAudioPlayer?
    @IBOutlet var button : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var ErrorMessage : UILabel!
    let defaults = UserDefaults.standard
    @IBAction func resetScores(sender : UIButton) {
        if sender.currentTitle == "Start New Game" {
            for x in 0 ... 8 {
                for y in 0 ... 8 {
                    defaults.set("", forKey: String(y + 1 + ((x + 1) * 10)))
                }
                defaults.set("", forKey: String((x + 1) * 10))
            }
            defaults.set("true", forKey: "boardChoice")
            defaults.set("5", forKey: "nextBoard")
            defaults.set("1", forKey: "turn")
            defaults.set("yes", forKey: "newGame?")
            defaults.set("Player 1 please choose a board.", forKey: "instructions")
            performSegue(withIdentifier: "startNewGame", sender: nil)
        } else if sender.currentTitle == "Resume Game" {
            if defaults.string(forKey: "savedData?") == nil || defaults.string(forKey: "savedData?") != "yes" {
                ErrorMessage.alpha = 1.0
            } else {
                performSegue(withIdentifier: "resumeGame", sender: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.string(forKey: "try") == nil {
            defaults.set("0", forKey: "coins")
            Game.coins = 0
            defaults.set("X", forKey: "character1")
            defaults.set("O", forKey: "character2")
            defaults.set("none", forKey: "x photo")
            defaults.set("none", forKey: "y photo")
        }
        defaults.set("no", forKey: "try")
        if Menu.player == nil {
            guard let url = Bundle.main.url(forResource: "Music", withExtension: "mp3") else {
                print("error")
                return
            }
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                Menu.player = try AVAudioPlayer(contentsOf: url)
                guard let player = Menu.player else { return }
                player.numberOfLoops = -1
                player.play()
            } catch let error {
                print(error)
            }
        }
        Game.coins = Int(defaults.string(forKey: "coins")!)!
        if let x = defaults.string(forKey: "musicVolume") {
            Menu.player!.volume = Float(x)!
        }
    }
}
