import UIKit

class InviteEmailViewController: UIViewController {

    @IBOutlet weak var headerViewHolder: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var btnSendInvite: StandardButton!
    
    fileprivate let inviteEmailViewModel = InviteEmailViewModel()
    fileprivate var headerViewController = HeaderViewController(title: "Invite", leftButton: .back, rightButton: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteEmailViewModel.delegate = self
        
        headerViewController.embedInView(headerViewHolder, parentViewController: self)
        headerViewController.delegate = self
        
        textFieldEmail.tintColor = UIColor.customSlateGrayColor()
        textFieldEmail.attributedPlaceholder = NSMutableAttributedString(string: textFieldEmail.placeholder ?? "", attributes: [NSForegroundColorAttributeName : UIColor.customCharcoalGreyColor()])
        textFieldEmail.becomeFirstResponder()
        inviteEmailViewModel.updateEmailAddress(emailAddress: textFieldEmail.text ?? "")
    }
    
    @IBAction func textFieldEmailEditingChanged(_ sender: UITextField) {
        if let emailAddress = sender.text {
            inviteEmailViewModel.updateEmailAddress(emailAddress: emailAddress)
        }
    }
    
    @IBAction func btnSendInvitePressed(_ sender: UIButton) {
        if let emailAddress = textFieldEmail.text {
            inviteEmailViewModel.sendInviteToEmailAddress(emailAddress: emailAddress)
        }
    }
    
}

// MARK: - InviteEmailViewModelDelegate

extension InviteEmailViewController: InviteEmailViewModelDelegate {
    
    func updateSubmitStatus(canSubmit: Bool) {
        btnSendInvite.isEnabled = canSubmit
    }
    
    func inviteRequestComplete(success: Bool) {
        if success {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension InviteEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - HeaderViewControllerDelegate

extension InviteEmailViewController: HeaderViewControllerDelegate {
    
    func leftButtonPressed(_ sender: HeaderViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
