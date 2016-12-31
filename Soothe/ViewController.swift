//
//  ViewController.swift
//  Soothe
//
//  Created by Ben Sarrazin on 2016-12-29.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var leadingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftButton: NSButton!
    @IBOutlet private weak var rightButton: NSButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftButton.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func leftButtonClicked(_ sender: NSButton) {
        guard leadingLayoutConstraint.constant < 0 else {
            return
        }
        NSAnimationContext.runAnimationGroup({ _ in
            leadingLayoutConstraint.animator().constant += view.frame.width
        }) { self.updateUserInterface() }
    }
    
    @IBAction func rightButtonClicked(_ sender: NSButton) {
        guard leadingLayoutConstraint.constant >= -(3 * view.frame.width) else {
            return
        }
        NSAnimationContext.runAnimationGroup({ _ in
            self.leadingLayoutConstraint.animator().constant -= self.view.frame.width
        }) { self.updateUserInterface() }
    }
    
    // MARK: - User Interface
    
    private func updateUserInterface() {
        leftButton.isHidden = leadingLayoutConstraint.constant == 0
        rightButton.isHidden = leadingLayoutConstraint.constant == -(3 * view.frame.width)
    }
    
}
