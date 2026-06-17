import Foundation

final class GameEngine {
    private let calculator: GenerationCalculator
    private(set) var grid: Grid
    
    // Проверка отсутствия активных ячеек
    var isExtinct: Bool {
        for i in 0..<grid.rows {
            for j in 0..<grid.columns {
                if grid.cell(row: i, column: j).isActive {
                    return false
                }
            }
        }
        
        return true
    }
    
    var isStable: Bool {
        grid == calculator.nextGeneration(from: grid)
    }
    
    init(calculator: GenerationCalculator, grid: Grid) {
        self.calculator = calculator
        self.grid = grid
    }
    
    // Следующее поколение
    func advance() {
        grid = calculator.nextGeneration(from: grid)
    }
    
    // Изменение состояния клетки
    func toggleCell(row: Int, col: Int) {
        grid.toggleCell(row: row, column: col)
    }
    
    // Очистка поля
    func clear() {
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                grid.cellState(row: row, column: column, active: false)
            }
        }
    }
    
    // Случайная генерация
    func randomize() {
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                grid.cellState(row: row, column: column, active: Bool.random())
            }
        }
    }
}
