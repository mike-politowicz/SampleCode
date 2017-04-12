protocol InviteEmailViewModelDelegate: class {
    func updateSubmitStatus(canSubmit: Bool)
    func inviteRequestComplete(success: Bool)
}

class InviteEmailViewModel {
    
    weak var delegate: InviteEmailViewModelDelegate?
    
    func updateEmailAddress(emailAddress: String) {
        delegate?.updateSubmitStatus(canSubmit: (emailAddress != ""))
    }
    
    func sendInviteToEmailAddress(emailAddress: String) {
        // TODO: Send request to InviteService
        delegate?.inviteRequestComplete(success: true)
    }
    
}
