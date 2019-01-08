//: [Previous](@previous)

import Foundation

/*
 [3, 0, 8, 4],
 [2, 4, 5, 7],
 [9, 2, 6, 3],
 [0, 3, 1, 0]
 */

let grid = [[59,88,44],[3,18,38],[21,26,51]]

func maxIncreaseKeepingSkyline(_ grid: [[Int]]) -> Int {
  
  var rowMax = [Int]()
  var colMax = [Int]()
  var sum = 0
  
  for i in 0..<grid.count {
    var row = [Int]()
    var column = [Int]()
    for j in 0..<grid[i].count {
      row.append(grid[i][j])
      column.append(grid[j][i])
    }
    rowMax.append(row.max() ?? 0)
    colMax.append(column.max() ?? 0)
  }
  
  rowMax
  colMax
  
  for i in 0..<grid.count {
    for j in 0..<grid[i].count {
      sum += (min(colMax[i], rowMax[j]) - grid[i][j])
    }
  }
  return sum
}

maxIncreaseKeepingSkyline(grid)
