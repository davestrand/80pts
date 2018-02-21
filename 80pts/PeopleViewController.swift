//
//  PeopleViewController.swift
//  80pts
//
//  Created by Levy,David A. on 6/7/17.
//  Copyright © 2017 mcc. All rights reserved.
//


//TODO: Enable gaps of employment option.  So you can add years missed working.
//TODO: Maybe a little meter on the PeopleView for each person.


import UIKit


class PeopleViewController: UIViewController{
    
    var tempNameString = ""
    
    
    @IBOutlet weak var pplView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Defaults.group?.synchronize()
        Person.registerClassName()
        loadPeople()
 
        //NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged(_:)), name: Notification.Name(rawValue: "orientationWillChange"), object: nil)

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func refreshTable(){
        assignSelectedName()
        tempNameString = Selected.id
        pplView.reloadData()
    }
    
    func assignSelectedName ()  {
        if let data =  Defaults.group?.data(forKey: Key.currentEmployee), let lastPersonChecked = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
            
            Helper.setAsSelected(thisPerson: lastPersonChecked)
        }
    }
    
    func loadPeople() {
        if let data =  Defaults.group?.data(forKey: Key.people), let thesePeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] {
            ppl = thesePeople
        }
        pplView.reloadData()
    }
}

extension PeopleViewController :  UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ppl.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! PeopleCell
        
        //TODO: Maybe add some color to cell selections.. other than white/grey
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if personExists(from:indexPath.row, in:ppl) {
            
            let thisPerson = ppl[indexPath.row]
            Helper.setAsSelected(thisPerson: thisPerson)
            cell.name.text = thisPerson.name
            var bodyText = ""
            
            if Determine.oldEnoughToWork(person: thisPerson) {
                let answer = Determine.retirement(person: thisPerson, longForm: false)
                bodyText = answer.body
            } else {
                bodyText = "\(Text.ageAlert1) \(thisPerson.age) \(Text.ageAlert2)"
            }
            
            cell.information.text = bodyText
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
    
    
    @objc func editAction (_ sender: UIButton) {
        Helper.setAsSelected(thisPerson: ppl[sender.tag])
        showEditScreen()
    }
    
    func personExists (from row:Int, in ppl:[Person]) -> Bool {
        if row < ppl.count {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if personExists(from:indexPath.row, in:ppl) {
            Helper.setAsSelected(thisPerson: ppl[indexPath.row])
            showCalculatedAnswer(person: ppl[indexPath.row])
        } else {
            let newEmployee = Person.init(name: Text.noName, uid: UUID().uuidString, birthday: [10,20,1974], started: [1,5,2005], age: 0, points: 0, yearsWorked: 0, birthdayFirst: false, pointsNeededToRetire: 80, batch: 3, eligible: false, reasonEligible: Text.notYetEligible,    percentOfWages: 55.00, wageMultiplier: 2.20, wageYearsRequired: 25)
            
            Helper.setAsSelected(thisPerson: newEmployee)
            People.add(thisPerson: newEmployee)
            showEditScreen()
        }
        
        Helper.persistSelectedEmployee(person: Selected.person)
        People.persist(ppl: ppl)
        pplView.reloadData()
        refreshTable()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if personExists(from:indexPath.row, in:ppl) {
                
                ppl.remove(at: indexPath.row)
            
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            
            }
        }
    }
    
    
    func showEditScreen () {
        
       
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailedView = storyBoard.instantiateViewController(withIdentifier: "edit") as! EditViewController
        
        let backItem = UIBarButtonItem()
        backItem.title = Text.saveAndExit
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(detailedView, animated: true)
    }
    
    
    func popWebpage(urlString:String) {
        if let url = NSURL(string: urlString){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    

    
    
    func popBenefits() {
        if let url = NSURL(string: Key.urlBenefits){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    func popEligibility() {
        if let url = NSURL(string: Key.urlEligibility){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func popOfficialOptions(_ sender: Any) {
        
        
        let bodyText = Text.linksBody
        
        let alert = UIAlertController(title: Text.linksTitle, message: bodyText, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: Text.linkBenefits, style: UIAlertActionStyle.default) { action in
            self.popBenefits()
            
        })
        alert.addAction(UIAlertAction(title: Text.linkEligibility, style: UIAlertActionStyle.default) { action in
            self.popEligibility()
            
        })
        
        alert.addAction(UIAlertAction(title: Text.ok, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
        
    }
    
    @IBAction func popInfo(_ sender: Any) {
        
        var version = ""
        
        if let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version = v
        }
        
        
        let alert = UIAlertController(title: Text.infoTitle + "\(version)", message: Text.infoBody, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Text.ok, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension PeopleViewController {
    
    func showCalculatedAnswer(person:Person) {
        
        var bodyText = ""
        var titleText = ""
        
        if Determine.oldEnoughToWork(person: person) {
            let answer = Determine.retirement(person: person, longForm: true)
            bodyText = answer.body
            titleText = answer.title
        } else {
            bodyText = "\(Text.ageAlert1) \(person.age) \(Text.ageAlert2)"
        }
        
        
        let alert = UIAlertController(title: titleText, message: bodyText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Text.howMuch, style: UIAlertActionStyle.default) { action in
            self.popUpRates(person: person)
        })
        alert.addAction(UIAlertAction(title: Text.ok, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAgeWarning(person:Person) {
        let alert = UIAlertController(title: Text.ageWarnTitle, message: "\(Text.ageWarnBody1) \(person.age) \(Text.ageWarnBody2)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Text.ok, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popUpRates(person:Person) {
        
        let asrPayRates = "\(Text.ratesBody1)\(person.yearsWorked)\(Text.ratesBody2)\(Determine.monthlyCompensation(i:person.yearsWorked))\(Text.ratesBody3)\(Determine.batchText(b: person.batch))"
        
        let alert = UIAlertController(title: Text.howMuch, message: asrPayRates, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Text.ok, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    //https://benincosa.com/?p=3280
    
//    func orientationChanged(notification: NSNotification ){
//        print("Recieved notification of orientation change")
//        UIDevice.current.orientation
//        if let info = notification.userInfo as? Dictionary<String,NSNumber> {
//            if let ori = info["orientation"] {
//                print("orientation: \(ori)")
//                let newOr : UIDeviceOrientation = UIDeviceOrientation(rawValue: ori.intValue)!
//                rotateSubviewsForOrientation(orientation: newOr)
//            }
//        }
//    }
    
    func rotateSubviewsForOrientation(orientation: UIDeviceOrientation) {
        // rotate the subviews.
        switch orientation {
        case UIDeviceOrientation.landscapeLeft:
            // home buitton facing right
            subLabelTransform(f: CGFloat(Double.pi / 2))
        case UIDeviceOrientation.landscapeRight:
            // home button facing left
            subLabelTransform(f: CGFloat(3 * Double.pi / 2))
        default:
            subLabelTransform(f: CGFloat(0))
        }
    }
    
    func subLabelTransform(f: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            //
            //self.label1.transform = CGAffineTransformMakeRotation(f)
            //self.label2.transform = CGAffineTransformMakeRotation(f)
            //self.mainLabel.transform = CGAffineTransformMakeRotation(f)
            
        }) { (Bool) -> Void in
            print("Done")
        }
        
        
    }
}


