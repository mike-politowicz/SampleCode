import Foundation

protocol InviteHomeViewModelDelegate: class {
    func showAlertForDeniedContactPermissions()
    func transitionToRequestContactPermissions()
    func transitionToShowContactsList()
}

class InviteHomeViewModel {
    
    weak var delegate: InviteHomeViewModelDelegate?
    
    func inviteViaContactsSelected() {
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.hasRequestedContactsPermissions.rawValue) {
            ContactService.requestContactPermission() { [weak self] isGranted in
                DispatchQueue.main.async {
                    if isGranted {
                        self?.delegate?.transitionToShowContactsList()
                    } else {
                        self?.delegate?.showAlertForDeniedContactPermissions()
                    }
                }
            }
        } else {
            delegate?.transitionToRequestContactPermissions()
        }
    }
    
}
