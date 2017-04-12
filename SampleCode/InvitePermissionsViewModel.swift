import Foundation

protocol InvitePermissionsViewModelDelegate: class {
    func transitionToShowContactsList()
    func transitionToDeniedPermission()
}

class InvitePermissionsViewModel {
    
    weak var delegate: InvitePermissionsViewModelDelegate?
    
    func requestContactPermission() {
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasRequestedContactsPermissions.rawValue)
        ContactService.requestContactPermission() { [weak self] isGranted in
            DispatchQueue.main.async {
                if isGranted {
                    self?.delegate?.transitionToShowContactsList()
                } else {
                    self?.delegate?.transitionToDeniedPermission()
                }
            }
        }
    }
    
}
