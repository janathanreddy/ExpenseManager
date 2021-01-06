//
//  ViewController.swift
//  ExpenseManager
//
//  Created by Janarthan Subburaj on 06/01/21.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet var UpdateView: UIView!
    @IBOutlet weak var Amount_Update: UITextField!
    @IBOutlet weak var Payer_Update: UITextField!
    @IBOutlet weak var Category_Update: UITextField!
    @IBOutlet weak var Payment_Update: UITextField!
    @IBOutlet weak var Details_Update: UITextField!
    @IBOutlet weak var Date_Update: UITextField!
    @IBOutlet weak var Time_Update: UITextField!
    
    @IBOutlet weak var Update_btn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AddItemBtn: UIButton!
    var date_String:String = ""
    var ExpenseAttribute = [IncomeExpense]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        AddItemBtn.layer.cornerRadius = 3
        Update_btn.layer.cornerRadius = 5
        loadtask()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadtask()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExpenseAttribute.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell", for: indexPath) as! ExpenseTableViewCell
         
        ExpenseTableViewCell.Amount.text = ExpenseAttribute[indexPath.row].amount_attribute
        ExpenseTableViewCell.Amount.textAlignment = .center
        ExpenseTableViewCell.CategoryLabel.text = ExpenseAttribute[indexPath.row].category_attribute
        ExpenseTableViewCell.PayerLabel.text = ExpenseAttribute[indexPath.row].payer_attribute
        ExpenseTableViewCell.PaymentLabel.text = ExpenseAttribute[indexPath.row].paymentmethod_attribute
        if ExpenseAttribute[indexPath.row].incomeorexpense_attribute == "Expense"{
            ExpenseTableViewCell.Amount.backgroundColor = UIColor.systemRed
            ExpenseTableViewCell.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0.8, alpha: 1.0)

        }else{
            ExpenseTableViewCell.Amount.backgroundColor = UIColor.systemGreen
            
        }
        
        return ExpenseTableViewCell
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        let InputViewController = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        self.navigationController!.pushViewController(InputViewController, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            let Tasks = ExpenseAttribute[indexPath.row]
            ExpenseAttribute.remove(at: indexPath.row)
            context.delete(Tasks)
            
            do {
                try context.save()
            } catch {
                print("Error deleting Task with \(error)")
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        }
    }
    
    
    func loadtask() {
        
        let fetchRequest = NSFetchRequest<IncomeExpense>(entityName: "IncomeExpense")
        
        let sort = NSSortDescriptor(key: "date_attribute", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            ExpenseAttribute = try context.fetch(fetchRequest)
        } catch {
            print("Cannot fetch Todo")
        }
        tableView.reloadData()
    }
    
    @IBAction func Update_Act(_ sender: Any) {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "IncomeExpense")
   fetchRequest.predicate = NSPredicate(format: "date_attribute = %@", "\(date_String)")
        do
        {
            let test = try context.fetch(fetchRequest)
           let objectUpdate = test[0] as! NSManagedObject
           let objectUpdate1 = test[0] as! NSManagedObject
           let objectUpdate2 = test[0] as! NSManagedObject
           let objectUpdate3 = test[0] as! NSManagedObject
           let objectUpdate4 = test[0] as! NSManagedObject
            let objectUpdate5 = test[0] as! NSManagedObject
            let objectUpdate6 = test[0] as! NSManagedObject


           objectUpdate.setValue("\(Amount_Update.text!)", forKey: "amount_attribute")
           objectUpdate1.setValue("\(Payer_Update.text!)", forKey: "payer_attribute")
           objectUpdate2.setValue("\(Category_Update.text!)", forKey: "category_attribute")
           objectUpdate3.setValue("\(Payment_Update.text!)", forKey: "paymentmethod_attribute")
           objectUpdate4.setValue("\(Details_Update.text!)", forKey: "detailnotes_attribute")
           objectUpdate5.setValue("\(Date_Update.text!)", forKey: "date_attribute")
           objectUpdate6.setValue("\(Time_Update.text!)", forKey: "time_attribute")


                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            }
        catch
        {
            print(error)
           
        }
   animatedismiss(desiredView: UpdateView)
   tableView.reloadData()
    }
    
    func animateIn(desiredView:UIView){
        
        let backgroundView = self.view
        backgroundView?.addSubview(desiredView)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView?.center as! CGPoint
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 1

        })
        
    }
    
    func  animatedismiss(desiredView:UIView){
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 0
        },completion: { _ in desiredView.removeFromSuperview()} )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn(desiredView: UpdateView)
        date_String.append(ExpenseAttribute[indexPath.row].date_attribute!)
        Amount_Update.text = ExpenseAttribute[indexPath.row].amount_attribute
        Category_Update.text = ExpenseAttribute[indexPath.row].category_attribute
        Date_Update.text = ExpenseAttribute[indexPath.row].date_attribute
        Details_Update.text = ExpenseAttribute[indexPath.row].detailnotes_attribute
        Payer_Update.text = ExpenseAttribute[indexPath.row].payer_attribute
        Payment_Update.text = ExpenseAttribute[indexPath.row].paymentmethod_attribute
        Time_Update.text = ExpenseAttribute[indexPath.row].time_attribute
    }
    
}

