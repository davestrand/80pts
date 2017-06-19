//
//  PeopleViewController.swift
//  80pts
//
//  Created by Levy,David A. on 6/7/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController{
    
    var tempNameString = ""
    
    @IBOutlet weak var pplView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Defaults.group?.synchronize()
        Person.registerClassName()
        loadPeople()
        
        

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshTable()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func refreshTable(){
        assignSelectedName()
        tempNameString = Selected.id
        pplView.reloadData()
    }
    
    func assignSelectedName ()  {
        
        if let data =  Defaults.group?.data(forKey: Key.currentEmployee), let lastPersonChecked = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
            
            setAsSelected(thisPerson: lastPersonChecked)
        }
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
        
        //let view = UIView()
       // cell.selectedBackgroundView = view
        cell.selectionStyle = UITableViewCellSelectionStyle.blue

        
        if onTheList(list:list, row:indexPath.row) {
            
        
            
            let thisPerson = list[indexPath.row]
            
            setAsSelected(thisPerson: thisPerson)
            
            cell.name.text = thisPerson.name
            cell.information.text = calculateRetirement(person: thisPerson, longForm: false).body
            cell.edit.tag = indexPath.row
            cell.edit.addTarget(self, action: #selector(PeopleViewController.editAction(_:)), for: UIControlEvents.touchUpInside)
            cell.edit.isHidden = false
            cell.backgroundColor = Colors.cellBackgroundNormal

            
        } else {
            
            cell.name.text = Text.createNew
            cell.information.text = ""
            cell.edit.isHidden = true
            cell.backgroundColor = Colors.cellBackgroundCreateNew

        }
        
        if cell.name.text == tempNameString {
            cell.backgroundColor = Colors.cellBackgroundSelected
        }
        
        return cell
    }
    
    
    func editAction (_ sender: UIButton) {
        setAsSelected(thisPerson: list[sender.tag])
        showEditScreen()
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
            
            setAsSelected(thisPerson: list[indexPath.row])
            showCalculatedAnswer(person: list[indexPath.row])
            
        } else {
            

            let newEmployee = Person.init(name: Text.noName, uid: UUID().uuidString, birthday: [10,20,1974], started: [1,5,2005], age: 0, points: 0, yearsWorked: 0, birthdayFirst: false, pointsNeededToRetire: 80, batch: 3, eligible: false, reasonEligible: "Not yet eligible.",    percentOfWages: 55.00, wageMultiplier: 2.20, wageYearsRequired: 25)
            

            setAsSelected(thisPerson: newEmployee)

            People.add(thisPerson: newEmployee)
            showEditScreen()
        }
        
        persistSelectedEmployee(person: Selected.person)
        
        People.persist(ppl: list)
        
        pplView.reloadData()
        
        refreshTable()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            
            if onTheList(list: list, row: indexPath.row) {
                
                list.remove(at: indexPath.row)
            
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()

            
            }
            
            //tableView.reloadData()

        }
    }
    
    
    func showEditScreen () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailedView = storyBoard.instantiateViewController(withIdentifier: "edit") as! EditViewController
        
        let backItem = UIBarButtonItem()
        backItem.title = "Save and Exit"
        navigationItem.backBarButtonItem = backItem
        
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


extension PeopleViewController {
    
    func showCalculatedAnswer(person:Person) {
        
        let fancyText = calculateRetirement(person: person, longForm: true)
        let alert = UIAlertController(title: fancyText.title, message: fancyText.body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "How Much?", style: UIAlertActionStyle.default) { action in
            self.popUpRates(person: person)
        })
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAgeWarning(person:Person) {
        let alert = UIAlertController(title: "Hmm.", message: "Your starting age is \(person.age) which is not old enough to work in Arizona.  Please check both dates to be sure they are accurate.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popUpRates(person:Person) {
        
        let asrPayRates = "After working \(person.yearsWorked) years your Percentage of Average Monthly Compensation would likely be \(calculateMonthlyCompensation(i:person.yearsWorked)).  Remember, more Service Credits = higher percentage paid. \n5 = 10.50%\n10 = 21.00%\n15 = 31.50%\n20 = 43.00%\n23 = 49.45%\n25 = 55.00%\n27 = 59.40%\n30 = 69.00%\n32 = 73.60%\n\n\(batchText(b: person.batch))"
        
        let alert = UIAlertController(title: "How Much?", message: asrPayRates, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



