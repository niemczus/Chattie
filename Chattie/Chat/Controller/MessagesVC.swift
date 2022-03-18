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
        
        // Subscribe to Keyboard Will Show notifications
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillShow(_:)),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )

                // Subscribe to Keyboard Will Hide notifications
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillHide(_:)),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
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
                self.tableView.scrollToBottom()
            }
        }
    }
    
    @objc dynamic func keyboardWillShow(_ notification: NSNotification) {
        
        animateWithKeyboard(notification: notification) { keyboardFrame in
            let constant = keyboardFrame.height - 20
            self.chatContainerViewBottomConstraint.constant = constant
        }
            self.view.layoutIfNeeded()
            self.tableView.scrollToBottom()
        }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        animateWithKeyboard(notification: notification) { keyboardframe in
            self.chatContainerViewBottomConstraint.constant = 0
        }
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
        
        guard messageTextView.text.isEmpty == false else { return }
        
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

extension MessagesVC {
    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        
        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
        
        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)
            
            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }
        
        // Start the animation
        animator.startAnimation()
    }
}
