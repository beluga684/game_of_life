import Foundation

struct Cell {
    var isActive: Bool
}

struct Grid {
    let rows: Int
    let columns: Int
    
    private(set) var cells: [[Cell]]
    
    // Получение клетки
    func cell(row: Int, column: Int) -> Cell {
        return cells[row][column]
    }
    
    // Изменение состояния ячейки
    mutating func cellState(row: Int, column: Int, active: Bool) {
        cells[row][column].isActive = active
    }
    
    mutating func toggleCell(row: Int, column: Int) {
        cells[row][column].isActive.toggle()
    }
}
