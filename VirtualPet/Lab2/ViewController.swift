//
//  ViewController.swift
//  Lab2
//
//  Created by Jiwoo Seo on 6/20/20.
//  Copyright © 2020 Jiwoo Seo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // creative portion : sound effects
    /*
     AVAudioPlayer(). learned and implemented some of the lines from following websites
     https://developer.apple.com/documentation/avfoundation/avaudioplayer
     https://www.youtube.com/watch?v=dqad3XuMwHI
     */
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var playedNumber: UILabel!
    @IBOutlet weak var fedNumber: UILabel!
    
    @IBOutlet weak var petBack: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    
    @IBOutlet weak var happinessBarView: DisplayView!
    @IBOutlet weak var foodBarView: DisplayView!
    
    @IBOutlet weak var feedMeLabel: UILabel!
    
    @IBOutlet weak var petImage: UIImageView!
    
    private var currentPet: Pet!
    
    @IBOutlet weak var playCount: UILabel!
    @IBOutlet weak var feedCount: UILabel!
    
    
    var dogTime = Pet(type: .dog, image: UIImage(named: "dog")!, colour: UIColor(named: "Orange")!)
    var catTime = Pet(type: .cat, image: UIImage(named: "cat")!, colour: UIColor(named: "Blue")!)
    var birdTime = Pet(type: .bird, image: UIImage(named: "bird")!, colour: UIColor(named: "Green")!)
    var bunnyTime = Pet(type: .bunny, image: UIImage(named: "bunny")!, colour: UIColor(named: "Pink")!)
    var fishTime = Pet(type: .fish, image: UIImage(named: "fish")!, colour: UIColor(named: "Purple")!)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentPet = dogTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Dog", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        audioPlayer.prepareToPlay()
        updateDisplay()
    }
    
    
    
    @IBAction func dogSelected(_ sender: Any) {
        currentPet = dogTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Dog", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        updateDisplay()
    }
    
    @IBAction func catSelected(_ sender: Any) {
        currentPet = catTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Cats", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        updateDisplay()
    }
    
    @IBAction func birdSelected(_ sender: Any) {
        currentPet = birdTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Bird", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        updateDisplay()
    }
    
    @IBAction func bunnySelected(_ sender: Any) {
        currentPet = bunnyTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Bunny", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        updateDisplay()
        
    }
    
    @IBAction func fishSelected(_ sender: Any) {
        currentPet = fishTime
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Fish", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        updateDisplay()
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        // when pet should eat first
        if currentPet.foodBarValue <= 0 {
            playFail()
        }
            // when happiness level is already 10
        else if currentPet.happyBarValue == 10 {
            // do nothing
        }
        else {
            currentPet.play()
            updateBar()
        }
    }
    
    @IBAction func feedButton(_ sender: Any) {
        if currentPet.foodBarValue == 10 {
            feedFail()
        }
        else {
            currentPet.feed()
            updateBar()
        }
    }
    
    
    
    
    
    func updateDisplay() {
        audioPlayer.play()
        feedMeLabel.isHidden = true
        petImage.image = currentPet.image
        petBack.backgroundColor = currentPet.colour
        playButton.backgroundColor = currentPet.colour
        feedButton.backgroundColor = currentPet.colour
        playCount.text =  "Played: \(currentPet.played)"
        feedCount.text = "Fed: \(currentPet.fed)"
        happinessBarView.color = currentPet.colour
        foodBarView.color = currentPet.colour
        happinessBarView.value = CGFloat(Double(currentPet.happyBarValue) / 10)
        foodBarView.value = CGFloat(Double(currentPet.foodBarValue) / 10)
    }
    
    func updateBar() {
        feedMeLabel.isHidden = true
        happinessBarView.animateValue(to: CGFloat(Double(currentPet.happyBarValue) / 10))
        foodBarView.animateValue(to: CGFloat(Double(currentPet.foodBarValue) / 10))
        playCount.text =  "Played: \(currentPet.played)"
        feedCount.text = "Fed: \(currentPet.fed)"
        if currentPet.celebrate == true {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Yay", ofType: "mp3")!))
            }
            catch {
                print(error)
            }
            audioPlayer.play()
            UIView.animate(withDuration: 0.5, animations: {
                self.petImage.frame.origin.y -= 50
            }) {_ in
                UIView.animateKeyframes(withDuration: 0.5, delay: 0,  animations: { self.petImage.frame.origin.y += 50
                })
            }
        }
    }
    
    
    func playFail() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "feedMe", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        feedMeLabel.text = "feed me first!"
        feedMeLabel.isHidden = false
        audioPlayer.play()
    }
    
    func feedFail() {
        feedMeLabel.text = "I might throw up!"
        feedMeLabel.isHidden = false
        currentPet.feed()
        happinessBarView.animateValue(to: CGFloat(Double(currentPet.happyBarValue) / 10))
        foodBarView.animateValue(to: CGFloat(Double(currentPet.foodBarValue) / 10))
        playCount.text =  "Played: \(currentPet.played)"
        feedCount.text = "Fed: \(currentPet.fed)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

