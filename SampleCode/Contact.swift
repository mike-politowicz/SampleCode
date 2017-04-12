class Contact {
    
    let firstName: String
    let lastName: String
    let fullName: String
    var emailAddress: String?
    var phoneNumber: String?
    var inviteStatus = InviteStatus.notInvited
    
    init(firstName: String, lastName: String, fullName: String, emailAddress: String?, phoneNumber: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
    }
    
}

enum InviteStatus {
    case invited, notInvited
}
