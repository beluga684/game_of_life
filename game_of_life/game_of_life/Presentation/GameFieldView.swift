import UIKit

final class GameFieldView: UIView {
    var grid: Grid?

    // Callback нажатия
    var onCellTap: ((Int, Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // Рисование поля
    override func draw(_ rect: CGRect) {
        guard
            let context = UIGraphicsGetCurrentContext(),
            let grid,
            grid.rows > 0,
            grid.columns > 0
        else { return }
        
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(0.8)
        context.setFillColor(UIColor.black.cgColor)
        
        let cellWidth = rect.width / CGFloat(grid.columns)
        let cellHeight = rect.height / CGFloat(grid.rows)
        
        for row in 0...grid.rows {
            let y = CGFloat(row) * cellHeight
            
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        for column in 0...grid.columns {
            let x = CGFloat(column) * cellWidth
            
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        context.strokePath()
        
        for row in 0..<grid.rows {
            for column in 0..<grid.columns {
                if grid.cell(row: row, column: column).isActive {
                    let x = CGFloat(column) * cellWidth
                    let y = CGFloat(row) * cellHeight
                    let padding: CGFloat = 1
                    
                    let cellRect = CGRect(
                        x: x + padding,
                        y: y + padding,
                        width: cellWidth - padding * 2,
                        height: cellHeight - padding * 2
                    )
                    
                    context.fill(cellRect)
                }
            }
        }
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    @objc
    private func handleTap( _ recognizer: UITapGestureRecognizer ) {
        guard let grid = grid else { return }
        
        let point = recognizer.location(in: self)
    
        
        let cellWidth = bounds.width / CGFloat(grid.columns)
        let cellHeight = bounds.height / CGFloat(grid.rows)
        
        let column = Int(point.x / cellWidth)
        let row = Int(point.y / cellHeight)
        
        guard
            row >= 0,
            row < grid.rows,
            column >= 0,
            column < grid.columns
        else { return }
        
        onCellTap?(row, column)
    }
}
