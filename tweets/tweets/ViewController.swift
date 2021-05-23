//
//  ViewController.swift
//  tweets
//
//  Created by Кирилл Комаровский on 16.05.2021.
//

import UIKit



class ViewController: UIViewController, APITwitterDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var requestTextFiel: UITextField!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    let cellIdentifier = "cell"
    override func viewDidLoad() {
           super.viewDidLoad()
           
           tokenRequest(callback: runApi)
           self.requestTextField.delegate = self
       }


}

