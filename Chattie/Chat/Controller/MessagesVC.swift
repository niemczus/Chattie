//
//  MessagesVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 12/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessagesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: MessageTextView!
    
    let database = Firestore.firestore()
    lazy var messagesCollection = database.collection("messages")
    
    var chattieUser: ChattieUser!
    
    var messages = [Message(sender: "kyle", body: "What's up?"), Message(sender: "niemczus", body: "Good Meeaan!")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        messageTextView.growingTextViewDelegate = self
        
        print(chattieUser.userName)
        
//        tableView.isScrollEnabled = true
//        print("ChattieUser from messages")
//        print(chattieUser ?? "none")
    
        addObservers()
        observeMessages()
    }
    
    
    func addObservers() {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                                   object: nil,
                                                   queue: .main,
                                                   using: keyboardWillShow)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillHide)
    }
    
    func observeMessages() {
        messagesCollection.order(by: "creationDate").addSnapshotListener { snapshot, error in
            if let unwrappedSnapshot = snapshot {
                
                var messagesFromFirestore = [Message]()
                
                for document in unwrappedSnapshot.documents {
                    
                    let dictionary = document.data()
                    
                    guard
                        let sender = dictionary["sender"] as? String,
                        let body = dictionary["body"] as? String
                    else { return }
                    
                    print(sender)
                    print(body)
                    
                    let message = Message(sender: sender, body: body)
                    messagesFromFirestore.append(message)
                }
                self.messages = messagesFromFirestore
                self.tableView.reloadData()
            }
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let bottomInset = view.safeAreaInsets.bottom
        let keyboardHight = keyboardFrame.cgRectValue.height
        
        chatContainerViewBottomConstraint.constant = keyboardHight - bottomInset
        
//        UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        chatContainerViewBottomConstraint.constant = 0
    }
    
    @IBAction func didTapSignOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "segue.Chat.messegesToSignIn", sender: nil)
        } catch {
            print(error)
        }
    }
    
    func sendMessage() {
        
        let dataDictionary: [String : Any] = ["sender" : chattieUser.userName,
                                              "body" : messageTextView.text ?? "",
                                              "creationDate" : FieldValue.serverTimestamp()]
        
        messagesCollection.addDocument(data: dataDictionary) { error in
            if let unwrappedError = error {
                print(unwrappedError)
            } else {
                self.messageTextView.text.removeAll()
            }
        }
    }
    
    
    @IBAction func didTapSend(_ sender: UIButton) {
        messageTextView.endEditing(true)
        sendMessage()
    }
    
}

extension MessagesVC: GrowingTextViewDelegate {
    func growingTextView(_ growingTextView: GrowingTextView, heightDidChangeTo height: CGFloat) {
        
        chatContainerViewHeightConstraint.constant = height + 50

    }
}

extension MessagesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else { return UITableViewCell() }
    
        let message = messages[indexPath.row]
        let isFromCurrentUser = message.sender == chattieUser.userName
        cell.populate(with: message, isFromCurrentUser: isFromCurrentUser)
        
        return cell
    }
    

}
