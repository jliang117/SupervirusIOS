//
//  CategoryBitmask.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/21/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

enum CategoryBitmask: UInt32 {
    case heroVirus = 0
    case enemyVirus = 0b10
    case heroLasers = 0b100
    case screenBounds = 0b1000
}
