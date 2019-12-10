//
//  ViewController.swift
//  SWPersons
//
//  Created by Никита Главацкий on 04.12.2019.
//  Copyright © 2019 StreetPeople. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var jsonResult: [[String: Any]]?
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowResults", sender: self)
    }
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var loadingScreen: UIView!
    @IBAction func beginSearching(_ sender: Any) {
        let textField = sender as! UITextField
        if let personName = textField.text{
            loadingScreen.isHidden = false
            loadingActivity.startAnimating()
            let url = "https://swapi.co/api/people/?search=\(personName)"
            AF.request(url).responseJSON{ response in
                self.loadingScreen.isHidden = true
                self.loadingActivity.stopAnimating()
                switch response.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else {return}
                    let resultCount = json["count"] as! Int
                    if resultCount > 0 {
                        self.jsonResult = (json["results"] as! [[String: Any]])
                        self.performSegue(withIdentifier: "ShowResults", sender: self)
                    }else{
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Персонаж не найден", message: "Проверьте введенное имя", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Произошла ошибка", message: "Попробуйте еще раз", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "ShowResults":
            let personsListVC: PersonsListTableViewController = segue.destination as! PersonsListTableViewController
            if let jsonResult = self.jsonResult{
                personsListVC.json = jsonResult
            }
            self.jsonResult = nil
            
        case .none:
            print("")
        case .some(_):
            print("")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

