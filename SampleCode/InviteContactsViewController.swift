import UIKit

class InviteContactsViewController: UIViewController {

    @IBOutlet weak var headerViewHolder: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableViewContacts: UITableView!
    @IBOutlet weak var lblContacts: UILabel!
    
    var shouldRemovePresentingViewController = false
    
    fileprivate let inviteContactsViewModel = InviteContactsViewModel()
    fileprivate var headerViewController = HeaderViewController(title: "Invite", leftButton: .back, rightButton: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteContactsViewModel.delegate = self
        
        headerViewController.embedInView(headerViewHolder, parentViewController: self)
        headerViewController.delegate = self
        
        lblContacts.attributedText = NSMutableAttributedString(string: "CONTACTS",
                                                               attributes: [NSKernAttributeName : 2.0])
        textFieldSearch.tintColor = UIColor.customSlateGrayColor()
        textFieldSearch.attributedPlaceholder = NSMutableAttributedString(string: textFieldSearch.placeholder ?? "",
                                                                          attributes: [NSForegroundColorAttributeName :
                                                                                        UIColor.customCharcoalGreyColor()])
        // Add empty table footer view to force bottom separator to be displayed
        tableViewContacts.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let viewControllers = navigationController?.viewControllers, shouldRemovePresentingViewController {
            navigationController?.viewControllers.remove(at: viewControllers.count - 2)
        }
    }
    
    @IBAction func textFieldSearchEditingChanged(_ sender: UITextField) {
        if let searchText = sender.text {
            inviteContactsViewModel.filterContactsWith(searchParameter: searchText)
        }
    }
    
}

// MARK: - InviteContactsViewModelDelegate

extension InviteContactsViewController: InviteContactsViewModelDelegate {
    
    func refreshContactList() {
        tableViewContacts.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InviteContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Setting the height of the first cell (dummy cell) to '1' in order to force top separator to be displayed
        let cellHeight: CGFloat = 53
        return (indexPath.row == 0) ? 1 : cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Add an extra row for the dummy cell
        return inviteContactsViewModel.numberOfContactsToDisplay + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewContacts.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        guard indexPath.row > 0 else {
            cell.contentView.alpha = 0.0
            return cell
        }
        cell.contentView.alpha = 1.0
        // Adjust row index by one in order to account for dummy first cell
        let adjustedRowIndex = indexPath.row - 1
        cell.lblName.text = inviteContactsViewModel.nameForContactAt(index: adjustedRowIndex)
        cell.lblDetails.text = inviteContactsViewModel.detailsForContactAt(index: adjustedRowIndex)
        cell.imgViewRightIcon.image = (inviteContactsViewModel.stateForContactAt(index: adjustedRowIndex) == .invited) ?
                                                                            #imageLiteral(resourceName: "contact_selected_icon") : #imageLiteral(resourceName: "contact_unselected_icon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Adjust row index by one in order to account for dummy first cell
        inviteContactsViewModel.selectedContactAt(index: indexPath.row - 1)
    }
    
}

// MARK: - UITextFieldDelegate

extension InviteContactsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - HeaderViewControllerDelegate

extension InviteContactsViewController: HeaderViewControllerDelegate {
    
    func leftButtonPressed(_ sender: HeaderViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
