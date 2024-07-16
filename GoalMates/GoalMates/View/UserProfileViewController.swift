//
//  UserProfileViewController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/6/24.
//
import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.useNameLabel.text = post.name
        cell.goalLabel.text = post.goals.count > 0 ? post.goals[0] : ""
        cell.goalLabel2.text = post.goals.count > 1 ? post.goals[1] : ""
        cell.goalLabel3.text = post.goals.count > 2 ? post.goals[2] : ""
        cell.profileImage.image = UIImage(named: "placeHolderImage")
        
        return cell
    }
    
    var posts:[GoalPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GoalMates"
        navigationItem.hidesBackButton = true
        let nib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        updatePageInfo()
        getAllGoalPost()
    }
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        AuthController.signOutUser { success, error in
            if success {
                print("Great")
                self.navigationController?.popToRootViewController(animated: true)
            }else {
                print("error")
            }
        }
    }
    
    func updatePageInfo(){
        
        FireStoreController.getCurrentUserName {username, error in
            if let username = username {
                self.userNameLabel.text = username
                print("Got the username!!")
            }else {
                print("something went wrong in retrieving the user name")
            }
        }
        
        
    }
    
    func getAllGoalPost() {
        FireStoreController.getAllGoalPost { [weak self] (goalPosts, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching goal posts")
                }else {
                    self?.posts = goalPosts
                    self?.tableView.reloadData()
                    print("Fetched the goals")
                }
            }
        }
    }
}
