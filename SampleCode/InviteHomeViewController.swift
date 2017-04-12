import UIKit

class InviteHomeViewController: UIViewController {

    @IBOutlet weak var headerViewHolder: UIView!
    
    fileprivate var headerViewController = HeaderViewController(title: "Invite", leftButton: .back, rightButton: .none)
    fileprivate let inviteHomeViewModel = InviteHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteHomeViewModel.delegate = self
        
        headerViewController.embedInView(headerViewHolder, parentViewController: self)
        headerViewController.delegate = self
    }
    
    @IBAction func btnInviteViaContactsPressed(_ sender: UIButton) {
        inviteHomeViewModel.inviteViaContactsSelected()
    }
    
    fileprivate func navigateToSettings(_ alert: UIAlertAction) {
        self.navigationController?.dismiss(animated: false, completion: nil)
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
}

// MARK: - InviteHomeViewModelDelegate

extension InviteHomeViewController: InviteHomeViewModelDelegate {
    
    func showAlertForDeniedContactPermissions() {
        let alert = UIAlertController(title: "Can't access contacts",
                                      message: "Scratch Track doesn't have permission to access your contacts.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Change Settings", style: UIAlertActionStyle.default, handler: self.navigateToSettings))
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitionToRequestContactPermissions() {
        self.performSegue(withIdentifier: "segueInvitePermissions", sender: self)
    }
    
    func transitionToShowContactsList() {
        self.performSegue(withIdentifier: "segueInviteContacts", sender: self)
    }
    
}

// MARK: - HeaderViewControllerDelegate

extension InviteHomeViewController: HeaderViewControllerDelegate {
    
    func leftButtonPressed(_ sender: HeaderViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
