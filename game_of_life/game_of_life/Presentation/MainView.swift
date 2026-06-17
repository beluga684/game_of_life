import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: GameViewModel

    init(viewModel: GameViewModel = MainView.makeDefaultViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            GameFieldRepresentable(grid: viewModel.grid, onCellTap: { row, column in
                viewModel.didTapCell(row: row, column: column)
            })
            .aspectRatio(
                CGFloat(viewModel.grid.columns) / CGFloat(viewModel.grid.rows),
                contentMode: .fit
            )
            .padding()
            
            controlPanel
        }
    }
    
    private var controlPanel: some View {
        HStack {
            Button("Start") {}
            Button("Stop") {}
            Button("Next") {}
            Button("Clear") {}
        }
    }

    private static func makeDefaultViewModel() -> GameViewModel {
        let rows = 25
        let columns = 20
        let cells = Array(
            repeating: Array(repeating: Cell(isActive: false), count: columns),
            count: rows
        )
        let grid = Grid(rows: rows, columns: columns, cells: cells)
        let engine = GameEngine(calculator: GenerationCalculator(), grid: grid)

        return GameViewModel(engine: engine)
    }
}

#Preview {
    MainView()
}
