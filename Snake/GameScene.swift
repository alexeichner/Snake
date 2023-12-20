//
//  GameScene.swift
//  Snake
//
//  Created by Alex Eichner on 12/18/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var testNode: SKSpriteNode!
    var snakeDirection = "start"
    var squares: [[Square]] = []
    
    // array of tuples where the first int is the row and the second is the column
    var snake: [(Int, Int)] = []
//    var board: Board!
    
    override func didMove(to view: SKView) {
        testNode = SKSpriteNode(color: NSColor.blue, size: CGSize(width: 20.0, height: 20.0))
        testNode.position = CGPoint(x: 400, y: 400)
        testNode.zPosition = 3
        addChild(testNode)
        
        intializeBoard(size: 15)
    }
    
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        switch event.keyCode {
        case 125:
            snakeDirection = "down"
        case 124:
            snakeDirection = "right"
        case 126:
            snakeDirection = "up"
        case 123:
            snakeDirection = "left"
        default:
            print("default")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if snakeDirection == "down" {
            testNode.position.y -= 2
        } else if snakeDirection == "right" {
            testNode.position.x += 2
        } else if snakeDirection == "up" {
            testNode.position.y += 2
        } else if snakeDirection == "left" {
            testNode.position.x -= 2
        } else {
            
        }
    }
    
    func intializeBoard(size: Int) {
        //board = Board(size: 15)
        
        for row in 0..<size {
            var squareRow: [Square] = []
            for column in 0..<size {
                if row % 2 == 0 {
                    if column % 2 == 0 {
                        squareRow.append(createSquare(color: NSColor.white, row: row, column: column))
                        
                    } else {
                        squareRow.append(createSquare(color: NSColor.gray, row: row, column: column))
                    }
                } else {
                    if column % 2 == 0 {
                        squareRow.append(createSquare(color: NSColor.gray, row: row, column: column))
                    } else {
                        squareRow.append(createSquare(color: NSColor.white, row: row, column: column))
                    }
                }
            }
            squares.append(squareRow)
        }
    }
    
    func createSquare(color: NSColor, row: Int, column: Int) -> Square {
        let square = Square(row: row, column: column)
        square.position = CGPoint(x: 200 + (row*30), y: 200 + (column*30))
        square.size = CGSize(width: 30, height: 30)
        square.color = color
        square.zPosition = 2
        addChild(square)
        return square
    }
    
    func updateSnakePosition(direction: String) {
        
    }
}
