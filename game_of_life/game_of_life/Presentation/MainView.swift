import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: GameViewModel

    init(viewModel: GameViewModel = MainView.makeDefaultViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            statisticsPanel.padding(.horizontal)
            
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
    
    private var statisticsPanel: some View {
        HStack {
            Spacer()
            Text("Поколение: \(viewModel.generation)")
            Spacer()
            Text("Живых ячеек: \(viewModel.activeCellsCount)")
            Spacer()
        }
    }
    
    private var controlPanel: some View {
        HStack {
            Button("Random") {
                viewModel.random()
            }
            Button("Start") {
                viewModel.start()
            }
            Button("Stop") {
                viewModel.stop()
            }
            Button("Next") {
                viewModel.nextStep()
            }
            Button("Clear") {
                viewModel.clear()
            }
        }
    }

    private static func makeDefaultViewModel() -> GameViewModel {
        let rows = 40
        let columns = 30
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
