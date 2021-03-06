import UIKit

class ViewController: UIViewController {

    var playing = false
    let minTimeBetweenFlashes = 0.0625
    let maxTimeBetweenFlashes = 128.0
    var timeBetweenFlashes = 0.5
    var flashDuration = 0.04
    
    override func loadView() {
        view = StrobeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecognizers()
        playStrobe()
    }

    func blackPeriodOver() {
        if playing {
            flash()
        } else {
            displayPaused()
        }
    }
    
    func flash() {
        displayText("")
        white();
        startWhitePeriodTimer();
    }

    func whitePeriodOver() {
        black()
        if playing {
            startBlackPeriodTimer()
        } else {
            displayPaused()
        }
    }
    
    func playPause() {
        if playing {
            pauseStrobe()
        } else {
            playStrobe()
        }
    }

    func pauseStrobe() {
        playing = false
        displayPaused()
    }
    
    func displayPaused() {
        displayText("Paused")
    }
    
    func playStrobe() {
        playing = true
        flash()
    }
    
    func downSwipe() {
        slowDownFlashing();
    }

    func upSwipe() {
        speedUpFlashing();
    }

    func leftSwipe() {
        slowDownFlashing();
    }
    
    func rightSwipe() {
        speedUpFlashing();
    }

    func slowDownFlashing() {
        displayText(formattedTime(timeBetweenFlashes))
        timeBetweenFlashes *= 1.090507732665258
        if timeBetweenFlashes > maxTimeBetweenFlashes {
            timeBetweenFlashes = maxTimeBetweenFlashes
        }
    }
    
    func speedUpFlashing() {
        displayText(formattedTime(timeBetweenFlashes))
        timeBetweenFlashes /= 1.090507732665258
        if timeBetweenFlashes < minTimeBetweenFlashes {
            timeBetweenFlashes = minTimeBetweenFlashes
        }
    }
    
    
    func formattedTime(time: Double) -> String {
        return String(format:"%.3f", time)
    }
    
    //timer
    func startBlackPeriodTimer() {
        afterDelay(timeBetweenFlashes, selector:"blackPeriodOver")
    }

    func startWhitePeriodTimer() {
        afterDelay(flashDuration, selector:"whitePeriodOver")
    }

    func afterDelay(ti: NSTimeInterval, selector: Selector) {
        NSTimer.scheduledTimerWithTimeInterval(ti, target: self, selector: selector, userInfo: nil, repeats: false)
    }
    
    // view
    func strobeView() -> StrobeView {
        return view as! StrobeView
    }

    func displayText(text: String) {
        strobeView().displayText(text)
    }
    
    func black() {
        strobeView().black()
    }
    
    func white() {
        strobeView().white()
    }
    
    func addRecognizers() {
        addPlayPauseRecognizer()
        addDownRecognizer()
        addUpRecognizer()
        addLeftRecognizer()
        addRightRecognizer()
    }
    
    func addPlayPauseRecognizer() {
        addTapRecognizerToView(UIPressType.PlayPause, action: "playPause")
    }
    
    func addDownRecognizer() {
        addSwipeRecognizerToView(UISwipeGestureRecognizerDirection.Down, action: "downSwipe")
    }
    
    func addUpRecognizer() {
        addSwipeRecognizerToView(UISwipeGestureRecognizerDirection.Up, action: "upSwipe")
    }

    func addLeftRecognizer() {
        addSwipeRecognizerToView(UISwipeGestureRecognizerDirection.Left, action: "leftSwipe")
    }
    
    func addRightRecognizer() {
        addSwipeRecognizerToView(UISwipeGestureRecognizerDirection.Right, action: "rightSwipe")
    }

    func addTapRecognizerToView(pressType:UIPressType, action:Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: action)
        tapRecognizer.allowedPressTypes = [NSNumber(integer: pressType.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
    }

    func addSwipeRecognizerToView(direction:UISwipeGestureRecognizerDirection, action:Selector) {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: action)
        swipeRecognizer.direction = direction
        self.view.addGestureRecognizer(swipeRecognizer)
    }

}

