//
//  Square.swift
//  Snake
//
//  Created by Alex Eichner on 12/18/23.
//

import Foundation
import GameKit

class Square: SKSpriteNode {
    
    let row: Int
    let column: Int
    var isSnake = false
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        super.init(texture: nil, color: NSColor.black, size: CGSize(width: 10, height: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
