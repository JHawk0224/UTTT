//
//  Settings.swift
//  firsttime
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 iD Student. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
class Settings: UIViewController {
    @IBOutlet var slider : UISlider!
    let defaults = UserDefaults.standard
    @IBAction func sliderMoved() {
        Menu.player!.volume = slider.value
        defaults.set(String(slider.value), forKey: "musicVolume")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let x = defaults.string(forKey: "musicVolume") {
            slider.value = Float(x)!
        }
    }
}
