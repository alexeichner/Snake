//
//  Board.swift
//  Snake
//
//  Created by Alex Eichner on 12/18/23.
//

import Foundation
import GameKit

class Board {
    
    let size: Int
    var squares: [[Square]] = []
    
    init(size: Int) {
        self.size = size
        for row in 0..<size {
            var squareRow: [Square] = []
            for column in 0..<size {
                let square = Square(row: row, column: column)
                square.position = CGPoint(x: row*10, y: column*10)
                square.zPosition = 2
                // Makes the board a checkerboard pattern
                if row % 2 == 0 {
                    if column % 2 == 0 {
                        square.color = NSColor.brown
                    } else {
                        square.color = NSColor.cyan
                    }
                } else {
                    if column % 2 == 0 {
                        square.color = NSColor.cyan
                    } else {
                        square.color = NSColor.brown
                    }
                }
                squareRow.append(square)
            }
            squares.append(squareRow)
        }
    }
    
    func resetBoard() {
        for row in 0..<size {
            for column in 0..<size {
                squares[row][column].isSnake = false
            }
        }
        
        squares[0][0].isSnake = true
        squares[1][0].isSnake = true
        squares[2][0].isSnake = true
    }
    
    func getNeighbors(square: Square) -> [Square] {
        var neighbors: [Square] = []
        let offsets = [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1)]
        for (rowOffset, columnOffset) in offsets {
            
            let row = square.row + rowOffset
            let column = square.column + columnOffset
            if row >= 0 && row < size && column >= 0 && column < size {
                neighbors.append(squares[row][column])
            }
        }
        return neighbors
    }
}
