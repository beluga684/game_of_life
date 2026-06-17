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
        }.accentColor(.black)
    }
    
    private var statisticsPanel: some View {
        HStack {
            Spacer()
            Text("Generation: \(viewModel.generation)")
            Spacer()
            Text("Active cells: \(viewModel.activeCellsCount)")
            Spacer()
            Text("Status: \(viewModel.gameStatus)")
            Spacer()
        }.font(.title2)
    }
    
    private var controlPanel: some View {
        HStack {
            Button {
                viewModel.isRunning ? viewModel.stop() : viewModel.start()
            } label: {
                VStack{
                    viewModel.isRunning ?
                    Image(systemName: "pause").font(.title2) :
                    Image(systemName: "play").font(.title2)
                }
            }.buttonStyle(.glass)
            
            Button {
                viewModel.clear()
            } label: {
                Image(systemName: "trash")
            }.buttonStyle(.glass)
            
            Button {
                viewModel.random()
            } label: {
                Image(systemName: "wand.and.sparkles").font(.title2)
            }.buttonStyle(.glass)
            
            VStack {
                Text("Interval: \(viewModel.interval, specifier: "%.1f") sec")
                Slider(value: Binding(
                    get: { viewModel.interval },
                    set: { viewModel.updateInterval($0) }
                ),
                       in: 0.1...1.0,
                       step: 0.1
                ).frame(maxWidth: 400)
            }.padding(.leading)
        }
    }

    private static func makeDefaultViewModel() -> GameViewModel {
        let rows = 40
        let columns = 70
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
