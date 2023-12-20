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
    var frameCount = 0
    
    // array of tuples where the first int is the row and the second is the column
    var snake: [(Int, Int)] = []
    var headPosition = (1,1)
//    var board: Board!
    
    override func didMove(to view: SKView) {
//        testNode = SKSpriteNode(color: NSColor.blue, size: CGSize(width: 20.0, height: 20.0))
//        testNode.position = CGPoint(x: 400, y: 400)
//        testNode.zPosition = 3
//        addChild(testNode)
        
        intializeBoard(size: 15)
        squares[1][1].isSnake = true
        squares[1][1].color = NSColor.systemGreen
        //squares[1][2].isSnake = true
        //squares[1][3].isSnake = true
        headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: 1, headPositionY: 1)
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 125:
            snakeDirection = "down"
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 124:
            snakeDirection = "right"
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 126:
            snakeDirection = "up"
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 123:
            snakeDirection = "left"
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        default:
            print("default")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        frameCount += 1
        
        if frameCount % 10 == 0 {
            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        }
    }
    
    func intializeBoard(size: Int) {
        //board = Board(size: 15)
        
        for row in 0..<size {
            var squareRow: [Square] = []
            for column in 0..<size {
                squareRow.append(createSquare(color: NSColor.white, row: row, column: column))
            }
            squares.append(squareRow)
        }
    }
    
    func createSquare(color: NSColor, row: Int, column: Int) -> Square {
        let square = Square(row: row, column: column)
        square.position = CGPoint(x: 200 + (row*31), y: 200 + (column*31))
        square.size = CGSize(width: 30, height: 30)
        square.color = color
        square.zPosition = 2
        addChild(square)
        return square
    }
    
    func updateSnakePosition(direction: String, headPositionX: Int, headPositionY: Int) -> (Int, Int) {
//        for row in 0..<squares.count {
//            for column in 0..<squares.count {
//                if squares[row][column].isSnake {
//                    squares[row][column].color = NSColor.systemGreen
//                }
//            }
//        }
        
        if snakeDirection == "down" {
            squares[headPositionX][headPositionY].isSnake = false
            squares[headPositionX][headPositionY].color = NSColor.white
            squares[headPositionX][headPositionY - 1].isSnake = true
            squares[headPositionX][headPositionY - 1].color = NSColor.systemGreen
            return (headPositionX, headPositionY - 1)
        } else if snakeDirection == "right" {
            squares[headPositionX][headPositionY].isSnake = false
            squares[headPositionX][headPositionY].color = NSColor.white
            squares[headPositionX + 1][headPositionY].isSnake = true
            squares[headPositionX + 1][headPositionY].color = NSColor.systemGreen
            return (headPositionX + 1, headPositionY)
        } else if snakeDirection == "up" {
            squares[headPositionX][headPositionY].isSnake = false
            squares[headPositionX][headPositionY].color = NSColor.white
            squares[headPositionX][headPositionY + 1].isSnake = true
            squares[headPositionX][headPositionY + 1].color = NSColor.systemGreen
            return (headPositionX, headPositionY + 1)
        } else if snakeDirection == "left" {
            squares[headPositionX][headPositionY].isSnake = false
            squares[headPositionX][headPositionY].color = NSColor.white
            squares[headPositionX - 1][headPositionY].isSnake = true
            squares[headPositionX - 1][headPositionY].color = NSColor.systemGreen
            return (headPositionX - 1, headPositionY)
        } else {
            return (headPositionX, headPositionY)
        }
    }
    
    func getNeighboringSquares(square: Square) -> [Square] {
        var neighbors: [Square] = []
        let offsets = [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1)]
        for (rowOffset, columnOffset) in offsets {
            
            let row = square.row + rowOffset
            let column = square.column + columnOffset
            if row >= 0 && row < 15 && column >= 0 && column < 15 {
                neighbors.append(squares[row][column])
            }
        }
        return neighbors
    }
}
//TODO: Check if snake hits wall
//TODO: Make snake multiple squares

