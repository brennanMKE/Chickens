//
//  ViewController.swift
//  Chickens
//
//  Created by Brennan Stehling on 6/5/18.
//  Copyright © 2018 Brennan Stehling. All rights reserved.
//

import UIKit

struct Animation {
    static let Clear: CGFloat = 0.0
    static let Opaque: CGFloat = 1.0
}

class ViewController: UIViewController {
    let emojis = ["🐣","🐥","🐤","🐔",""]
    let duration: TimeInterval = 0.75
    let delay: TimeInterval = 0.25
    var index = -1

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }

    func startAnimation() {
        index = 0
        topLabel.alpha = 1.0
        bottomLabel.alpha = 0.0
        topLabel.text = emojis[0]
        bottomLabel.text = nil
        step()
    }

    func nextIndex() -> Int {
        return index == emojis.count - 1 ? 0 : index + 1
    }

    // 1) set bottom label to text from top label
    // 2) set top label to clear
    // 3) set bottom label to opaque
    // 4) set top level to index of next emoji
    // 5) animate bottom to clear and top to opaque
    // 6) call step when animation is done
    func step() {
        let previousIndex = index
        index = nextIndex()
        debugPrint("Step: \(previousIndex) to \(index)")
        
        bottomLabel.text = topLabel.text
        bottomLabel.alpha = Animation.Opaque
        topLabel.alpha = Animation.Clear
        topLabel.text = emojis[index]
        
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { 
            self.topLabel.alpha = Animation.Opaque
            self.bottomLabel.alpha = Animation.Clear
        }) { _ in
            self.step()
        }
    }

}
