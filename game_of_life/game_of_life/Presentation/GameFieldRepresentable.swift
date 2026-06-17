import SwiftUI

struct GameFieldRepresentable: UIViewRepresentable {
    let grid: Grid
    let onCellTap: (Int, Int) -> Void
    
    func makeUIView(context: Context) -> GameFieldView {
        let view = GameFieldView()
        view.onCellTap = onCellTap
        return view
    }
    
    func updateUIView(_ uiView: GameFieldView, context: Context) {
        uiView.grid = grid
        uiView.setNeedsDisplay()
    }
}
