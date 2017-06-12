//
//  PeopleViewController.swift
//  80pts
//
//  Created by Levy,David A. on 6/7/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController{
    
    @IBOutlet weak var pplView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Defaults.group?.synchronize()
        Person.registerClassName()

        loadPeople()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        pplView.reloadData()

    }

     
 
    func loadPeople() {
 
        if let data =  Defaults.group?.data(forKey: Key.people), let thesePeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] {
            list = thesePeople
        }
        
        pplView.reloadData()

        
    }

}

extension PeopleViewController :  UITableViewDelegate, UITableViewDataSource  {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return list.count + 1
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! PeopleCell
            
            
            if onTheList(list:list, row:indexPath.row) {

            let thisPerson = list[indexPath.row]
            
            cell.name.text = thisPerson.name
                
               
            if cell.name.text == selectedEmployee.name {
                
                cell.selectedOrNot.text = "."
                selectedEmployee = thisPerson
                setupData()
                
                cell.information.text = calculateRetirement(person: thisPerson, longForm: false).body
                
            } else {
                cell.selectedOrNot.text = ""
                selectedEmployee = thisPerson
                setupData()
                
                cell.information.text = calculateRetirement(person: thisPerson, longForm: false).body

            }
 
                
            } else {
                
                cell.name.text = Text.createNew
                cell.selectedOrNot.text = ""
                cell.information.text = ""
            }
            
            return cell
        }
    
    
    func onTheList (list:[Person], row:Int) -> Bool {
        
        if row < list.count {
            return true
        } else {
            return false
        }
        
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    
            if onTheList(list: list, row: indexPath.row) {

                selectedEmployee = list[indexPath.row]
                showEditScreen()
                
            } else {
                let newEmployee = Person.init(name: Text.noName, birthday: [10,20,1974], started: [1,5,2005], age: 0, points: 0, yearsWorked: 0, birthdayFirst: false, pointsNeededToRetire: 80, batch: 3, eligible: false, reasonEligible: "Not yet eligible.")
                
                selectedEmployee = newEmployee
                
                People.add(thisPerson: newEmployee)
                pplView.reloadData()
                
    
                
                showEditScreen()

            }
    

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            if onTheList(list: list, row: indexPath.row) {
                list.remove(at: indexPath.row)
            }
            
            tableView.reloadData()
        
        }
    }
    
    
    func showEditScreen () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailedView = storyBoard.instantiateViewController(withIdentifier: "edit") as! EditViewController
        navigationController?.pushViewController(detailedView, animated: true)
    }
    
    @IBAction func popRate(_ sender: Any) {
        if let url = NSURL(string: "https://www.azasrs.gov/content/estimate-your-benefits"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func popSite(_ sender: Any) {
        if let url = NSURL(string: "https://www.azasrs.gov/content/retirement-eligibility"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func popInfo(_ sender: Any) {
        
            var version = ""
            
            if let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                version = v
            }
            
            
            let alert = UIAlertController(title: "80 Points V\(version)", message: "An app by David Levy to calculate Arizona State Retirement eligibility based on the information provided on the official ASRS website. THIS IS NOT AN OFFICIAL ASRS TOOL, and any calculations or estimations provided here should be verified with your Human Resources department and official resources. ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    }

