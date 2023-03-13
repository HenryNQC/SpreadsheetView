//
//  Cells.swift
//  SpreadsheetView
//
//  Created by Kishikawa Katsumi on 5/8/17.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import SpreadsheetView

class HeaderCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TextCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TaskCell: Cell {
    let label = UILabel()

    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 0

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ChartBarCell: Cell {
    let colorBarView = UIView()
    let label = UILabel()
    private let overlay = UIView()
    private var lastPoint = CGPointZero

    var color: UIColor = .clear {
        didSet {
            colorBarView.backgroundColor = color
        }
    }

    override var frame: CGRect {
        didSet {
            colorBarView.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(colorBarView)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white

        contentView.addSubview(label)
        
        overlay.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        contentView.addSubview(overlay)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetSelectedArea() {
        overlay.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    func touchBegan(_ touch: UITouch) {
        lastPoint = touch.location(in: contentView)
    }
    
    func touchMoved(_ touch: UITouch) {
        let currentPoint = touch.location(in: contentView)
        reDrawSelectionArea(from: lastPoint, to: currentPoint)
    }
    
    func touchEnded(_ touch: UITouch) {
        let currentPoint = touch.location(in: contentView)
    }
    
    func reDrawSelectionArea(from startPoint: CGPoint, to endPoint: CGPoint) {
        overlay.isHidden = false
        
        let rect = CGRectMake(min(startPoint.x, endPoint.x), contentView.frame.minY, abs(startPoint.x - endPoint.x), contentView.frame.height)
        overlay.frame = rect
    }
}
