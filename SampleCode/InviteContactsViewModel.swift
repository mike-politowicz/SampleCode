import Contacts

protocol InviteContactsViewModelDelegate: class {
    func refreshContactList()
}

class InviteContactsViewModel {

    weak var delegate: InviteContactsViewModelDelegate?
    var numberOfContactsToDisplay: Int {
        return contacts.count
    }
    
    fileprivate var allContacts: [Contact]
    fileprivate var contacts: [Contact]
    
    init() {
        self.allContacts = ContactService.localContactsWithEmailOrPhone()
        self.contacts = allContacts
    }
    
    func nameForContactAt(index: Int) -> String {
        return contacts[index].fullName
    }
    
    func detailsForContactAt(index: Int) -> String {
        return contacts[index].emailAddress ?? contacts[index].phoneNumber ?? ""
    }
    
    func stateForContactAt(index: Int) -> InviteCellState {
        return (contacts[index].inviteStatus == .invited) ? .invited : .notInvited
    }
    
    func filterContactsWith(searchParameter: String) {
        if searchParameter == "" {
            contacts = allContacts
        } else {
            contacts = allContacts.filter() {
                $0.firstName.lowercased().contains(searchParameter.lowercased()) ||
                $0.lastName.lowercased().contains(searchParameter.lowercased()) ||
                $0.fullName.lowercased().contains(searchParameter.lowercased()) ||
                $0.emailAddress?.contains(searchParameter.lowercased()) ?? false ||
                $0.phoneNumber?.contains(searchParameter) ?? false ||
                $0.phoneNumber?.components(separatedBy: CharacterSet.decimalDigits.inverted)
                    .joined().contains(searchParameter) ?? false
            }
        }
        delegate?.refreshContactList()
    }
    
    func selectedContactAt(index: Int) {
        contacts[index].inviteStatus = .invited
        delegate?.refreshContactList()
    }
    
}

enum InviteCellState {
    case invited, loading, notInvited
}
