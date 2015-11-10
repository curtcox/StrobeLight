import UIKit

class ViewController: UIViewController {

    var playing = false
    let minTimeBetweenFlashes = 0.04
    let maxTimeBetweenFlashes = 100.0
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

    func startBlackPeriodTimer() {
        NSTimer.scheduledTimerWithTimeInterval(timeBetweenFlashes, target: self, selector: "blackPeriodOver", userInfo: nil, repeats: false)
    }
    
    func blackPeriodOver() {
        if (playing) {
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

    func startWhitePeriodTimer() {
        NSTimer.scheduledTimerWithTimeInterval(flashDuration, target: self, selector: "whitePeriodOver", userInfo: nil, repeats: false)
        if playing {
            startBlackPeriodTimer()
        } else {
            displayPaused()
        }
    }

    func whitePeriodOver() {
        if playing {
            black()
        } else {
            displayPaused()
        }
    }
    
    func black() {
        view.backgroundColor = UIColor.blackColor()
    }

    func white() {
        view.backgroundColor = UIColor.whiteColor()
    }

    func addRecognizers() {
        addPlayPauseRecognizer()
        addDownArrowRecognizer()
        addUpArrowRecognizer()
    }
    
    func addPlayPauseRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "playPause")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
    }

    func addDownArrowRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "downArrow")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.DownArrow.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
    }

    func addUpArrowRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "upArrow")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.UpArrow.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
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
        displayText("")
        startBlackPeriodTimer()
    }
    
    func downArrow() {
        slowDownFlashing();
        displayText(formattedTime(timeBetweenFlashes))
    }

    func upArrow() {
        speedUpFlashing();
        displayText(formattedTime(timeBetweenFlashes))
    }

    func slowDownFlashing() {
        timeBetweenFlashes *= 1.1
        if timeBetweenFlashes > maxTimeBetweenFlashes {
            timeBetweenFlashes = maxTimeBetweenFlashes
        }
    }
    
    func speedUpFlashing() {
        timeBetweenFlashes /= 1.1
        if timeBetweenFlashes < minTimeBetweenFlashes {
            timeBetweenFlashes = minTimeBetweenFlashes
        }
    }
    
    func displayText(text: String) {
        let strobeView = view as! StrobeView
        strobeView.text = text
        view.setNeedsDisplay()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func formattedTime(time: Double) -> String {
        return String(format:"%.3f", time)
    }
}

