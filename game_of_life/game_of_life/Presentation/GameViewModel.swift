import Foundation
import Combine

final class GameViewModel: ObservableObject {
    @Published private(set) var grid: Grid
    @Published private(set) var generation: Int = 0
    
    var activeCellsCount: Int {
        var result = 0
        
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                if grid.cell(row: row, column: column).isActive { result += 1 }
            }
        }
        
        return result
    }
    
    private let engine: GameEngine
    private var timer: Timer?

    init(engine: GameEngine) {
        self.engine = engine
        self.grid = engine.grid
    }

    // Запуск симуляции
    func start() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {[weak self] _ in
                self?.nextStep()
            }
        }
    }

    // Остановка симуляции
    func stop() {
        timer?.invalidate()
        timer = nil
    }

    // Следующий шаг
    func nextStep() {
        engine.advance()
        generation += 1
        updateGrid()
    }
    
    // Очистка поля
    func clear() {
        engine.clear()
        generation = 0
        updateGrid()
        
        stop()
    }
    
    // Рандом
    func random() {
        engine.randomize()
        generation = 0
        updateGrid()
        
        stop()
    }

    // Тап по клетке
    func didTapCell( row: Int, column: Int ) {
        engine.toggleCell(row: row, col: column)
        updateGrid()
    }

    // Синхронизация UI
    private func updateGrid() {
        grid = engine.grid
    }
}
