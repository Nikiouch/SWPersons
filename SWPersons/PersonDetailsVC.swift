//
//  PersonDetailsVC.swift
//  SWPersons
//
//  Created by Никита Главацкий on 05.12.2019.
//  Copyright © 2019 StreetPeople. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class PersonDetailsVC: UIViewController {

    var json: [String: Any]?
    var person: Person?
    let uiRealm = try! Realm()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightsLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let json = json{
            person = uiRealm.object(ofType: Person.self, forPrimaryKey: json["name"] as! String)
            if person == nil{
                person = Person()
                person!.name = json["name"] as! String
                try! uiRealm.write({ () -> Void in
                //                uiRealm.add(person!)
                    uiRealm.add(person!, update: .modified)
                })
            }
            try! uiRealm.write({ () -> Void in
                person!.height = Int(json["height"] as! String)!
                person!.mass = Int(json["mass"] as! String)!
                person!.birthYear = json["birth_year"] as! String
                person!.eyeColor = json["eye_color"] as! String
                person!.hairColor = json["hair_color"] as! String
                person!.gender = json["gender"] as! String
                person!.skinColor = json["skin_color"] as! String
            })
            
            
        }
        if let person = person{
            nameLabel.text = person.name
            heightsLabel.text = String(person.height)
            massLabel.text = String(person.mass)
            hairColorLabel.text = person.hairColor
            skinColorLabel.text = person.skinColor
            eyeColorLabel.text = person.eyeColor
            birthYearLabel.text = person.birthYear
            genderLabel.text = person.gender
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
