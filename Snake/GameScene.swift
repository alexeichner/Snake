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
    var gameStarted = false
    
    // array of tuples where the first int is the row and the second is the column
    var snake: [(Int, Int)] = []
    var headPosition = (1,1)
    
    override func didMove(to view: SKView) {
        
        intializeBoard(size: 15)
        squares[1][1].isSnake = true
        squares[1][1].color = NSColor.systemGreen
        squares[1][2].isSnake = true
        squares[1][2].color = NSColor.systemGreen
        snake.append(headPosition)
        snake.append((1,2))
        //squares[1][3].isSnake = true
//        headPosition = updateSnakePosition(direction: snakeDirection)
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 125:
            snakeDirection = "down"
            gameStarted = true
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 124:
            snakeDirection = "right"
            gameStarted = true
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 126:
            snakeDirection = "up"
            gameStarted = true
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        case 123:
            snakeDirection = "left"
            gameStarted = true
//            headPosition = updateSnakePosition(direction: snakeDirection, headPositionX: headPosition.0, headPositionY: headPosition.1)
        default:
            print("default")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        frameCount += 1
        
        if frameCount % 10 == 0 && gameStarted {
            headPosition = updateSnakePosition(direction: snakeDirection)
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
    
    func updateSnakePosition(direction: String) -> (Int, Int) {
        
        var posX = headPosition.0
        var posY = headPosition.1
        var newHeadPosition = (headPosition.0, headPosition.1)
        var oldHeadPosition = headPosition
        
        if snakeDirection == "down" {
            squares[posX][posY].isSnake = false
            squares[posX][posY].color = NSColor.white
            squares[posX][posY - 1].isSnake = true
            squares[posX][posY - 1].color = NSColor.systemGreen
            newHeadPosition = (posX, posY - 1)
        } else if snakeDirection == "right" {
            squares[posX][posY].isSnake = false
            squares[posX][posY].color = NSColor.white
            squares[posX + 1][posY].isSnake = true
            squares[posX + 1][posY].color = NSColor.systemGreen
            newHeadPosition = (posX + 1, posY)
        } else if snakeDirection == "up" {
            squares[posX][posY].isSnake = false
            squares[posX][posY].color = NSColor.white
            squares[posX][posY + 1].isSnake = true
            squares[posX][posY + 1].color = NSColor.systemGreen
            newHeadPosition = (posX, posY + 1)
        } else if snakeDirection == "left" {
            squares[posX][posY].isSnake = false
            squares[posX][posY].color = NSColor.white
            squares[posX - 1][posY].isSnake = true
            squares[posX - 1][posY].color = NSColor.systemGreen
            newHeadPosition = (posX - 1, posY)
        }
        
        let count = 1..<snake.count
        for i in count {
            let previousPos = snake[i]
            snake[i] = oldHeadPosition
            oldHeadPosition = previousPos
            
            if (i + 1) == snake.count {
                squares[oldHeadPosition.0][oldHeadPosition.1].isSnake = false
                squares[oldHeadPosition.0][oldHeadPosition.1].color = NSColor.white
            }
        }
        return newHeadPosition
    }
    
    func canMoveToNextSquare() -> Bool {
        var isAbleToMove = true
        
        return isAbleToMove
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

