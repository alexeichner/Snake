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
    var gameEnded = false
    
    // array of tuples where the first int is the row and the second is the column
    var snakeArray: [(Int, Int)] = []
    
    //the initial position of the snakes head
    var headPosition = (3,1)
    
    //the initial position of the food
    var foodPosition = (10, 1)
    
    override func didMove(to view: SKView) {
        //Create a new grid of squares
        intializeBoard(size: 15)
        
        //Creating the starting position of the snake
        squares[3][1].isSnake = true
        squares[3][1].color = NSColor.systemGreen
        squares[2][1].isSnake = true
        squares[2][1].color = NSColor.systemGreen
        squares[1][1].isSnake = true
        squares[1][1].color = NSColor.systemGreen
        
        //Adding the initial coordinates of the snake to the array
        snakeArray.append(headPosition)
        snakeArray.append((2,1))
        snakeArray.append((1,1))
        
        //Changes the color of the initial square with the food
        squares[foodPosition.0][foodPosition.1].color = NSColor.systemRed
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 125:
            snakeDirection = "down"
            gameStarted = true
        case 124:
            snakeDirection = "right"
            gameStarted = true
        case 126:
            snakeDirection = "up"
            gameStarted = true
        case 123:
            snakeDirection = "left"
            gameStarted = true
        default:
            print("default")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        frameCount += 1
        
        if frameCount % 10 == 0 && gameStarted && !gameEnded {
            updateSnakePosition()
            if headPosition == foodPosition {
                eatFood()
                spawnNewFood()
            }
        }
        
        
    }
    
    func intializeBoard(size: Int) {
        
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
    
    func updateSnakePosition() {
        /*
         We need to preserve the head position before we change it in the if statement so
         we can use it to update the rest of the snakes body
         */
        var previousBodyPosition = headPosition
        if snakeDirection == "down" && canMoveToNextSquare(direction: "down") {
            
            headPosition = (headPosition.0, headPosition.1 - 1)
            squares[headPosition.0][headPosition.1].color = NSColor.systemGreen
        } else if snakeDirection == "right" && canMoveToNextSquare(direction: "right") {
            
            headPosition = (headPosition.0 + 1, headPosition.1)
            squares[headPosition.0][headPosition.1].color = NSColor.systemGreen
        } else if snakeDirection == "up" && canMoveToNextSquare(direction: "up") {
            
            headPosition = (headPosition.0, headPosition.1 + 1)
            squares[headPosition.0][headPosition.1].color = NSColor.systemGreen
        } else if snakeDirection == "left" && canMoveToNextSquare(direction: "left") {
            
            headPosition = (headPosition.0 - 1, headPosition.1)
            squares[headPosition.0][headPosition.1].color = NSColor.systemGreen
        }
        
        /*
         Loops through all indices of snakeArray except the first because we already updated
         the headPosition in the above if statement. Updates the position of all the indices
         */
        for index in (1..<snakeArray.count) {
            //get the current index's position
            let currentIndexPosition = snakeArray[index]
            squares[currentIndexPosition.0][currentIndexPosition.1].color = NSColor.white
            
            //update the current index's position to the position of the previous index
            snakeArray[index] = previousBodyPosition
            squares[previousBodyPosition.0][previousBodyPosition.1].color = NSColor.systemGreen
            
            //update the value of previousBodyPosition so it contains the old value of the current index
            previousBodyPosition = currentIndexPosition
        }
    }
    
    func eatFood() {
        //Temporarily giving the newSquarePosition the position of the last square in the snakeArray
        var newSquarePosition = snakeArray[snakeArray.count - 1]
        
        if snakeDirection == "down" {
            newSquarePosition = (newSquarePosition.0, newSquarePosition.1 - 1)
        } else if snakeDirection == "right" {
            newSquarePosition = (newSquarePosition.0 + 1, newSquarePosition.1)
        } else if snakeDirection == "up" {
            newSquarePosition = (newSquarePosition.0, newSquarePosition.1 + 1)
        } else if snakeDirection == "left" {
            newSquarePosition = (newSquarePosition.0 - 1, newSquarePosition.1)
        }
        snakeArray.append(newSquarePosition)
        squares[newSquarePosition.0][newSquarePosition.1].isSnake = true
        squares[newSquarePosition.0][newSquarePosition.1].color = NSColor.systemGreen
    }
    
    func spawnNewFood() {
    
        var availableSquares: [(Int,Int)] = []
        
        for row in 0..<squares.count {
            for col in 0..<squares[row].count {
                if !squares[row][col].isSnake {
                    availableSquares.append((row,col))
                }
            }
        }
        
        let randomNumber = Int.random(in: 0..<availableSquares.count)
        
        foodPosition = availableSquares[randomNumber]
        squares[foodPosition.0][foodPosition.1].color = NSColor.systemRed
    }
    
    func canMoveToNextSquare(direction: String) -> Bool {
        let posX = headPosition.0
        let posY = headPosition.1
        
        if direction == "down" {
            if posY - 1 < 0 {
                gameEnded = true
            }
        } else if direction == "right" {
            if posX + 1 > 14 {
                gameEnded = true
            }
        } else if direction == "up" {
            if posY + 1 > 14 {
                gameEnded = true
            }
        } else if direction == "left" {
            if posX - 1 < 0 {
                gameEnded = true
            }
        }
        //return gameEnded
        return true
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

