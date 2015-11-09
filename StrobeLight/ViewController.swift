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

    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(timeBetweenFlashes, target: self, selector: "flash", userInfo: nil, repeats: false)
    }
    
    func flash() {
        white();
        blackAfterDelay();
    }

    func blackAfterDelay() {
        NSTimer.scheduledTimerWithTimeInterval(flashDuration, target: self, selector: "black", userInfo: nil, repeats: false)
        if playing {
            startTimer()
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
        displayText("Paused")
    }
    
    func playStrobe() {
        playing = true
        displayText("")
        startTimer()
    }
    
    func downArrow() {
        slowDownFlashing();
    }

    func upArrow() {
        speedUpFlashing();
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
    }
    
}

