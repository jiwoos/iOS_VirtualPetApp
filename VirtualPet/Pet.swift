//
//  Pet.swift
//  Lab2
//
//  Created by Jiwoo Seo on 6/20/20.
//  Copyright © 2020 Jiwoo Seo. All rights reserved.
//

import UIKit

class Pet {
    var fed:Int
    var played:Int
    var petKind:petType
    var image: UIImage
    var type: petType
    var colour: UIColor
    private (set) var happyBarValue: Int
    private (set) var foodBarValue: Int
    var celebrate: Bool
    
    
    enum petType {
        case dog
        case cat
        case bird
        case bunny
        case fish
    }
    
    // Behavior
    func feed() {
        if foodBarValue == 10 {
            celebrate = false
            if happyBarValue > 0 {
                happyBarValue -= 1
            }
        }
        else {
            fed += 1
            foodBarValue += 1
            celebrate = false
        }
    }
    
    func play() {
        if foodBarValue > 0 && happyBarValue < 10{
            played += 1
            foodBarValue -= 1
            happyBarValue += 1
            celebrate = false
        }
        if happyBarValue == 10 {
            celebrate = true
        }
    }
    
    //Init
    init(type: petType, image: UIImage, colour: UIColor) {
        self.type = type
        self.image = image
        self.fed = 0
        self.played = 0
        self.colour = colour
        petKind = type
        self.happyBarValue = 0
        self.foodBarValue = 0
        self.celebrate = false
    }
}
