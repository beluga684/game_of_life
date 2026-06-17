import Foundation
import Combine

final class GameViewModel: ObservableObject {
    @Published private(set) var grid: Grid
    private let engine: GameEngine
    private var timer: Timer?

    init(engine: GameEngine) {
        self.engine = engine
        self.grid = engine.grid
    }

    // Запуск симуляции
    func start() {
        fatalError("Implement")
    }

    // Остановка симуляции
    func stop() {
        fatalError("Implement")
    }

    // Следующий шаг
    func nextStep() {
        fatalError("Implement")
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
