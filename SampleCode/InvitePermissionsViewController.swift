import UIKit

class InvitePermissionsViewController: UIViewController {

    @IBOutlet weak var headerViewHolder: UIView!
    
    fileprivate let invitePermissionsViewModel = InvitePermissionsViewModel()
    fileprivate var headerViewController = HeaderViewController(title: "Allow Access", leftButton: .back, rightButton: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invitePermissionsViewModel.delegate = self
        
        headerViewController.embedInView(headerViewHolder, parentViewController: self)
        headerViewController.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let contactsViewController = segue.destination as? InviteContactsViewController
        contactsViewController?.shouldRemovePresentingViewController = true
    }
    
    @IBAction func btnNextPressed(_ sender: UIButton) {
        invitePermissionsViewModel.requestContactPermission()
    }

}

// MARK: - InvitePermissionsViewModelDelegate

extension InvitePermissionsViewController: InvitePermissionsViewModelDelegate {
    
    func transitionToDeniedPermission() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func transitionToShowContactsList() {
        self.performSegue(withIdentifier: "segueInviteContacts", sender: self)
    }
    
}

// MARK: - HeaderViewControllerDelegate

extension InvitePermissionsViewController: HeaderViewControllerDelegate {
    
    func leftButtonPressed(_ sender: HeaderViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
