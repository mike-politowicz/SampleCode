import Contacts

class ContactService {

    static func requestContactPermission(completionHandler: @escaping (Bool) -> ()) {
        let contactStore = CNContactStore()
        contactStore.requestAccess(for: .contacts) { (isGranted, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            completionHandler(isGranted)
        }
    }
    
    static func localContactsWithEmailOrPhone() -> [Contact] {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey] as! [CNKeyDescriptor]

        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [Contact] = []
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate,
                                                                        keysToFetch: keysToFetch)
                containerResults.forEach({ (contact) -> Void in
                    guard (contact.emailAddresses.count > 0) || (contact.phoneNumbers.count > 0) else {
                        return
                    }
                    let newContact = Contact(firstName: contact.givenName,
                                             lastName: contact.familyName,
                                             fullName: CNContactFormatter.string(from: contact, style: .fullName) ??
                                                contact.givenName + " " + contact.familyName,
                                             emailAddress: contact.emailAddresses.first?.value as String?,
                                             phoneNumber: contact.phoneNumbers.first?.value.stringValue as String?)
                    results.append(newContact)
                })
            } catch {
                print("Error fetching results for container")
            }
        }
        return results
    }
    
}
