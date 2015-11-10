import Foundation
import UIKit

class StrobeView: UIView {
    
    var text = ""
    
    override func drawRect(rect: CGRect) {
        let fieldFont = UIFont(name: "Helvetica Neue", size: 500)
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: fieldFont!
        ]
        
        text.drawInRect(rectForText(), withAttributes: attributes as? [String : AnyObject])
        
    }
    
    func rectForText() -> CGRect {
        return CGRect(origin: upperLeft(), size: UIScreen.mainScreen().bounds.size)
    }

    func upperLeft() -> CGPoint {
        let y = 250
        if text == "Paused" {
            return CGPoint(x: 100, y: y)
        }
        if text.hasPrefix("0.") {
            return CGPoint(x: 500, y: y)
        }
        if text.characters.count > 6 {
            return CGPoint(x: 0, y: y)
        }
        return CGPoint(x: 50, y: y)
    }
}