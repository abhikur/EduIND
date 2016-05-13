import UIKit
import CoreData

class StoredStudentsTVC: UITableViewController {
    
    let context = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let request = NSFetchRequest(entityName: "Student")
        do{
            students = try context?.executeFetchRequest(request) as! [Student]
        }catch {
            let errorMsg = UIAlertView(title: "Error", message: "Cannot collect data", delegate: nil, cancelButtonTitle: "OK")
            errorMsg.show()
        }
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let student = students[indexPath.row]
        cell.textLabel?.text = student.firstName
        cell.detailTextLabel?.text = student.lastName
        
        return cell
    }
    
    func filterRecord(searchFor: String) {
        let request = NSFetchRequest(entityName: "Student")
        let predicate = NSPredicate(format: "firstName contains %@", searchFor)
        request.predicate = predicate
        do{
            students = try context?.executeFetchRequest(request) as! [Student]
        }catch{
            let errorMsg = UIAlertView(title: "Error", message: "Not matched with the data", delegate: nil, cancelButtonTitle: "Ok")
            errorMsg.show()
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func findStudent(sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "Search", message: "Enter name of Student", preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addTextFieldWithConfigurationHandler{(StudentName: UITextField!)-> Void in
            StudentName.placeholder = "Name of Student"
        }
        
        let okBtn = UIAlertAction(title: "Search", style: UIAlertActionStyle.Default){(alert: UIAlertAction!) in
            let studentName = alertView.textFields![0] as UITextField
            self.filterRecord(studentName.text!)
            alertView.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertView.addAction(okBtn)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel){
            (alert: UIAlertAction!) in
            alertView.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertView.addAction(cancel)
        presentViewController(alertView, animated: true, completion: nil)
        
        
    }
}
