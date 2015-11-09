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
        return CGRect(origin: CGPoint(x: 0, y: 0), size: UIScreen.mainScreen().bounds.size)
    }

}