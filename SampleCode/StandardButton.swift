import UIKit

@IBDesignable

class StandardButton: UIButton {

    var buttonStyle: StandardButtonStyle = .solidColor {
        didSet {
            self.configureButton()
        }
    }
    override var isEnabled: Bool {
        didSet {
            self.alpha = (isEnabled) ? 1.0 : 0.5
        }
    }
    override var frame: CGRect {
        didSet {
            self.configureButton()
        }
    }
    @IBInspectable var customColor: UIColor = UIColor.white {
        didSet {
            self.configureButton()
        }
    }
    @IBInspectable var fontSize: Int = 10 {
        didSet {
            self.configureButton()
        }
    }
    @IBInspectable var buttonStyleEnum: Int {
        get {
            return self.buttonStyle.rawValue
        }
        set(buttonStyleIndex) {
            self.buttonStyle = StandardButtonStyle(rawValue: buttonStyleIndex) ?? .solidColor
        }
    }
    
    fileprivate var titleText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureButton()
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        self.titleText = title
        configureButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animateShrinking(shrinkScale: 0.96)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animateUnshrinking()
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animateUnshrinking()
        super.touchesCancelled(touches, with: event)
    }
    
    fileprivate func configureButton() {
        self.layer.cornerRadius = frame.height / 2.0
        var textColor = UIColor.white
        
        switch buttonStyle {
        case .green:
            self.backgroundColor = UIColor.customGreenButtonColor()
            textColor = UIColor.white
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.0
        case .red:
            self.backgroundColor = UIColor.customRedButtonColor()
            textColor = UIColor.white
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.0
        case .solidColor:
            self.backgroundColor = customColor
            textColor = UIColor.white
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.0
        case .whiteBorderThick:
            self.backgroundColor = UIColor.clear
            textColor = UIColor.white
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 2.0
        case .whiteBorderThin:
            self.backgroundColor = UIColor.clear
            textColor = UIColor.white
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.0
        case .thickBorder:
            self.backgroundColor = UIColor.clear
            textColor = customColor
            self.layer.borderColor = customColor.cgColor
            self.layer.borderWidth = 2.0
        case .thinBorder:
            self.backgroundColor = UIColor.clear
            textColor = customColor
            self.layer.borderColor = customColor.cgColor
            self.layer.borderWidth = 1.0
        }
        
        let buttonTextAttributes = [NSFontAttributeName : UIFont.defaultRegularFontWithSize(CGFloat(self.fontSize)), NSKernAttributeName : 2.0, NSForegroundColorAttributeName : textColor] as [String : Any]
        self.setAttributedTitle(NSMutableAttributedString(string: self.titleText ?? self.titleLabel?.text ?? "", attributes: buttonTextAttributes), for: .normal)
    }

}

enum StandardButtonStyle: Int {
    case green, red, solidColor, whiteBorderThick, whiteBorderThin, thickBorder, thinBorder
}
