import Foundation

final class GenerationCalculator {
    func nextGeneration(from grid: Grid) -> Grid {
        var result = grid
        
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                let neighboursCount = activeNeighbours(row: row, column: column, grid: grid)
                let isActive = grid.cell(row: row, column: column).isActive
                
                if !isActive && neighboursCount == 3 {
                    result.cellState(row: row, column: column, active: true)
                } else if isActive && (neighboursCount == 2 || neighboursCount == 3) {
                    result.cellState(row: row, column: column, active: true)
                } else {
                    result.cellState(row: row, column: column, active: false)
                }
            }
        }
        
        return result
    }
    
    private func activeNeighbours(row: Int, column: Int, grid: Grid) -> Int {
        var result = 0
        let windowRow = row - 1...row + 1
        let windowColumn = column - 1...column + 1
        
        for i in windowRow {
            for j in windowColumn {
                guard i >= 0,
                      i < grid.rows,
                      j >= 0,
                      j < grid.columns
                else { continue }
                
                if i == row && j == column { continue }
                
                if grid.cell(row: i, column: j).isActive { result += 1 }
            }
        }
        
        return result
    }
}
