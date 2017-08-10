//
//  ViewController.swift
//  swivl_test_task
//
//  Created by Admin on 08.08.17.
//  Copyright © 2017 FC. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var user : String?
    var users = [String]()
    
    @IBOutlet weak var FollowersListPV: UIPickerView!
    

    func loadFollowers() {
        
        users.removeAll()
        
        let theurl = "https://api.github.com/users/\(self.user!)/followers"
        let requestURL: URL = URL(string: theurl.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        print(requestURL)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL)
        urlRequest.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
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
                
                for (_, subJson):(String, JSON) in json {

                    self.users += [subJson["login"].stringValue]
                    
                }
                
                DispatchQueue.main.async {
                    self.FollowersListPV.reloadAllComponents()
                    print(self.users.count)
                }
            }
                
            else {print("Error - no response")}
        })
        
        task.resume()
        
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        users.append("Loading...")
        FollowersListPV.reloadAllComponents()
        
        self.loadFollowers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return users.count
        
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return users[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}
