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
    
    
    var apiController: APIController?
    var tweets = [Tweet]()
    let cellIdentifier = "cell"
    override func viewDidLoad() {
           super.viewDidLoad()
           
           tokenRequest(callback: runApi)
           self.requestTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.text != nil {
                self.requestTextField.endEditing(true)
                apiController?.performRequest(withString: textField.text!)
                return true
            }
            return false
        }
        
        func runApi(token: String) {
             self.apiController = APIController(delegate: self, token: token)
            apiController?.performRequest(withString: "ecole 42")
        }
        
        func tokenRequest(callback:  @escaping (String) -> Void ) {
            
            var ac: String = ""
            let CONSUMER_KEY = "puzm9RbgxUCE0uEhx8zSBkV5B"
            let CONSUMER_SECRET = "ameiMkigEOdIkTOGeWKXjq0JNlV3CMloNzIg13BObFC6JPWqkv"
            let BEARER = (CONSUMER_KEY + ":" + CONSUMER_SECRET).data(using: String.Encoding.utf8)?.base64EncodedString()
            
            let url = URL(string: "https://api.twitter.com/oauth2/token")
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("Basic " + BEARER!, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                //print(response!)
                if let err = error {
                    self.error(err as NSError)
                }
                else if let d = data {
                    do {
                        if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                            print(dic["access_token"]!)
                            ac = dic.value(forKey: "access_token") as! String
                            print(ac)
                            callback(ac)
                        }
                    }
                    catch (let err) {
                        self.error(err as NSError)
                    }
                }
            })
            task.resume()
        }
        
        func error(_ error: NSError) {
            //print("Oops, some error handling")
            let alert = UIAlertController(title: "Oops", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (alert: UIAlertAction) in self.tokenRequest(callback: self.runApi)}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
        
        func takeTweets(tweets: [Tweet]) {
            self.tweets = tweets
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets.count
        }

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TwitterTableViewCell

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            let d = dateFormatter.date(from: self.tweets[indexPath.row].date)
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
            
            cell.dateLabel.text = dateFormatter.string(from: d!)
            cell.nameLabel.text = self.tweets[indexPath.row].name
            cell.tweetText.text = self.tweets[indexPath.row].text
            
            return cell
   
}

