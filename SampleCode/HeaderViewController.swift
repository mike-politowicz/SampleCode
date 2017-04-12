import UIKit

protocol HeaderViewControllerDelegate: class {
    func leftButtonPressed(_ sender: HeaderViewController)
    func rightButtonPressed(_ sender: HeaderViewController)
}

class HeaderViewController: UIViewController {

    enum HeaderButtonType {
        case join, login, next, done, save, back, close, downArrow, more, add, none
    }
    
    weak var delegate: HeaderViewControllerDelegate?
    var headerTitle: String {
        didSet {
            guard oldValue != "" else {
                self.lblTitle?.text = self.headerTitle
                return
            }
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
                self.lblTitle.alpha = 0.0
                }, completion: { _ in
                    self.lblTitle?.text = self.headerTitle
                    UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
                        self.lblTitle.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    var leftHeaderButton: HeaderButtonType {
        didSet {
            configureHeaderButton(btnLeft, buttonType: leftHeaderButton)
        }
    }
    var rightHeaderButton: HeaderButtonType {
        didSet {
            configureHeaderButton(btnRight, buttonType: rightHeaderButton)
        }
    }
    var backgroundColor = UIColor.customDefaultHeaderBackgroundColor() {
        didSet {
            self.view.backgroundColor = self.backgroundColor
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    init(title: String, leftButton: HeaderButtonType, rightButton: HeaderButtonType) {
        self.headerTitle = title
        self.leftHeaderButton = leftButton
        self.rightHeaderButton = rightButton
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = headerTitle
        configureHeaderButton(btnLeft, buttonType: leftHeaderButton)
        configureHeaderButton(btnRight, buttonType: rightHeaderButton)
    }
    
    @IBAction func btnLeftPressed(_ sender: UIButton) {
        delegate?.leftButtonPressed(self)
    }
    
    @IBAction func btnRightPressed(_ sender: UIButton) {
        delegate?.rightButtonPressed(self)
    }
    
    func setBtnLeftEnabled(_ enabled: Bool) {
        btnLeft.isEnabled = enabled
        btnLeft.alpha = enabled ? 1.0 : 0.4
    }
    
    func setBtnRightEnabled(_ enabled: Bool) {
        btnRight.isEnabled = enabled
        btnRight.alpha = enabled ? 1.0 : 0.4
    }
    
    func configureHeaderButton(_ button: UIButton, buttonType: HeaderButtonType) {
        button.setAttributedTitle(nil, for: .normal)
        button.setImage(nil, for: .normal)
        button.isEnabled = true
        var text: String?
        var image: UIImage?
        var nearSideAndTopMargins = CGPoint(x: 20.0, y: 41.0)
        var desiredContentSize = button.frame.size
        var edgeInsets = UIEdgeInsets.zero
        
        switch buttonType {
        case .join:
            text = "JOIN"
        case .login:
            text = "LOGIN"
        case .next:
            text = "NEXT"
        case .done:
            text = "DONE"
        case .save:
            text = "SAVE"
        case .back:
            image = UIImage(named: "back_btn")
            desiredContentSize = CGSize(width: 19, height: 16)
            nearSideAndTopMargins.y = 37.0
        case .close:
            image = UIImage(named: "close_btn")
            desiredContentSize = CGSize(width: 15, height: 16)
            nearSideAndTopMargins.y = 38.0
        case .downArrow:
            image = UIImage(named: "down_arrow")
            desiredContentSize = CGSize(width: 11, height: 7)
            nearSideAndTopMargins.x = 25.0
            nearSideAndTopMargins.y = 43.0
        case .more:
            image = UIImage(named: "more_icon_big")
            desiredContentSize = CGSize(width: 24, height: 5)
            nearSideAndTopMargins.x = 22.0
            nearSideAndTopMargins.y = 43.0
        case .add:
            image = UIImage(named: "add_btn")
            desiredContentSize = CGSize(width: 19, height: 18)
            nearSideAndTopMargins.x = 19.0
            nearSideAndTopMargins.y = 35.0
        case .none:
            text = ""
            button.isEnabled = false
        }
        if let buttonText = text {
            let attributedText = NSMutableAttributedString(string: buttonText, attributes: [NSKernAttributeName : 2.0])
            button.setAttributedTitle(attributedText, for: .normal)
            desiredContentSize = attributedText.boundingRect(with: button.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
        }
        if button == btnLeft {
            edgeInsets.left = nearSideAndTopMargins.x - button.frame.origin.x
            edgeInsets.top = nearSideAndTopMargins.y - button.frame.origin.y
            edgeInsets.right = button.frame.size.width - desiredContentSize.width - edgeInsets.left
            edgeInsets.bottom = button.frame.size.height - desiredContentSize.height - edgeInsets.top
        } else if button == btnRight {
            edgeInsets.right = nearSideAndTopMargins.x - (view.frame.width - (button.frame.origin.x + button.frame.size.width))
            edgeInsets.top = nearSideAndTopMargins.y - button.frame.origin.y
            edgeInsets.left = button.frame.size.width - desiredContentSize.width - edgeInsets.right
            edgeInsets.bottom = button.frame.size.height - desiredContentSize.height - edgeInsets.top
        }
        if text != nil {
            button.titleEdgeInsets = edgeInsets
        }
        if let buttonImage = image {
            button.setImage(buttonImage, for: .normal)
            button.imageEdgeInsets = edgeInsets
        }
    }
}

extension HeaderViewControllerDelegate {
    
    func leftButtonPressed(_ sender: HeaderViewController) {
        return
    }
    
    func rightButtonPressed(_ sender: HeaderViewController) {
        return
    }
    
}
