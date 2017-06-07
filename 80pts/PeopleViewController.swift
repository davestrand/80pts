//
//  PeopleViewController.swift
//  80pts
//
//  Created by Levy,David A. on 6/7/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController{
    
    @IBOutlet weak var addPersonButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        Defaults.group?.synchronize()
        Person.registerClassName()
        People.registerClassName()

        loadPeople()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        tableView.reloadData()
        print("appeared")
    }

    
    @IBAction func addPerson(_ sender: Any) {
        
        People.add(thisPerson: thisEmployee)
        People.persist(ppl: list)
        tableView.reloadData()

    }
    
    
    func loadPeople() {
        
        if let data =  Defaults.group?.data(forKey: Key.people), let thesePeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] {
            list = thesePeople
        } else {
            print("There is an issue")
        }
        
        
        tableView.reloadData()

        
    }

}

extension PeopleViewController :  UITableViewDelegate, UITableViewDataSource  {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return list.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
            
            cell.textLabel?.text = list[indexPath.row].name
            
            return cell
        }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You selected cell #\(indexPath.row)!")
            
            thisEmployee = list[indexPath.row]
   
            showEditScreen()
    
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            list.remove(at: indexPath.row)
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

