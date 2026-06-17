import Foundation
import Combine
import UIKit

final class GameViewModel: ObservableObject {
    @Published private(set) var grid: Grid
    @Published private(set) var generation: Int = 0
    @Published private(set) var isRunning = false
    
    @Published var interval: TimeInterval = 0.5
    
    var activeCellsCount: Int {
        var result = 0
        
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                if grid.cell(row: row, column: column).isActive { result += 1 }
            }
        }
        
        return result
    }
    
    var gameStatus: String {
        if engine.isExtinct {
            return generation > 0 ? "Extinct" : "Clear"
        } else if engine.isStable {
            return "Stable"
        } else if isRunning {
            return "Running"
        }
        return "Stoped"
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
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
                self?.nextStep()
            }
        }
    }
    
    func updateInterval(_ newInterval: TimeInterval) {
        interval = newInterval
        
        if isRunning {
            stop()
            start()
        }
    }

    // Остановка симуляции
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    // Следующий шаг
    func nextStep() {
        if engine.isExtinct || engine.isStable {
            stop()
            return
        }
        
        engine.advance()
        generation += 1
        
        playGenerationFeedback()
        
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
    
    private func playGenerationFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    deinit { timer?.invalidate() }
}
