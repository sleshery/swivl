//
//  UserListTableViewController.swift
//  swivl_test_task
//
//  Created by Admin on 08.08.17.
//  Copyright © 2017 FC. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    struct gitUser {
        
        var login: String?
        var htmlURL: String?
        var avatarURL: String?
        
        init() {
            
        }
        
    }
    
    var users = [gitUser]()
    
    func loadGit() {
        
        users.removeAll()
        
        let theurl = "https://api.github.com/users?since=0"
        let requestURL: URL = URL(string: theurl.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        print(requestURL)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL)
        urlRequest.setValue("<https://api.github.com/users?page=1&per_page=100>; rel=\"first\"", forHTTPHeaderField: "Link")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {
            (data1, response, error) -> Void in
            guard error == nil && data1 != nil else {
                let _error = error as? NSError
                let themessage : String
                if _error?.code == -1001 {
                    themessage = "Надто довго чекаємо дані. У тебе все гаразд з мережею?"
                }
                else { themessage = "Упс..Неочікувана помилка. Повідомте розробника" }
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Помилка :(", message: themessage, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                print("error=\(_error?.code), \(_error?.localizedDescription)")
                return
            }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(response)
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                
                print(data1)
                let json = JSON(data: data1!)
                //print(json)
                
                
                for (_, subJson):(String, JSON) in json {
                    //Do something you want
                    var user = gitUser()
                    user.login = subJson["login"].string
                    user.htmlURL = subJson["html_url"].string
                    user.avatarURL = subJson["avatar_url"].string
                    self.users.append(user)
                }
                
             self.tableView.reloadData()
            }
                
            else {print("Error - no response")}
        })
        
        task.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.loadGit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)

        cell.textLabel?.text = self.users[indexPath.row].login ?? "O_o"
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
