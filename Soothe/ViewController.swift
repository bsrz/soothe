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
        guard leadingLayoutConstraint.constant < 0 else { return }
        let changes = { (context: NSAnimationContext) in
            self.leadingLayoutConstraint.animator().constant += self.view.frame.width
        }
        let completion = {
            self.updateUserInterface()
        }
        NSAnimationContext.runAnimationGroup(changes, completionHandler: completion)
    }
    
    @IBAction func rightButtonClicked(_ sender: NSButton) {
        guard leadingLayoutConstraint.constant >= -(3 * view.frame.width) else { return }
        let changes = { (context: NSAnimationContext) in
            self.leadingLayoutConstraint.animator().constant -= self.view.frame.width
        }
        let completion = {
            self.updateUserInterface()
        }
        NSAnimationContext.runAnimationGroup(changes, completionHandler: completion)
    }
    
    // MARK: - User Interface
    
    private func updateUserInterface() {
        leftButton.isHidden = leadingLayoutConstraint.constant == 0
        rightButton.isHidden = leadingLayoutConstraint.constant == -(3 * view.frame.width)
    }
    
}
