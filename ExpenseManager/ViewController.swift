//
//  ViewController.swift
//  ExpenseManager
//
//  Created by Janarthan Subburaj on 06/01/21.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet var UpdateView: UIView!
    @IBOutlet weak var Amount_Update: UITextField!
    @IBOutlet weak var Payer_Update: UITextField!
    @IBOutlet weak var Category_Update: UITextField!
    @IBOutlet weak var Payment_Update: UITextField!
    @IBOutlet weak var Details_Update: UITextField!
    
    @IBOutlet weak var Update_btn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AddItemBtn: UIButton!
    var date_String:String = ""
    var ExpenseAttribute = [IncomeExpense]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        Bottomline()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 111
        AddItemBtn.layer.cornerRadius = 3
        Update_btn.layer.cornerRadius = 5
        CancelBtn.layer.cornerRadius = 5
        loadtask()
        UpdateView.layer.borderWidth = 1
        UpdateView.layer.borderColor = UIColor.black.cgColor
        UpdateView.layer.cornerRadius = 10
        UpdateView.dropShadow(color: .systemPink, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadtask()
        tableView.rowHeight = 111
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
                
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

           objectUpdate.setValue("\(Amount_Update.text!)", forKey: "amount_attribute")
           objectUpdate1.setValue("\(Payer_Update.text!)", forKey: "payer_attribute")
           objectUpdate2.setValue("\(Category_Update.text!)", forKey: "category_attribute")
           objectUpdate3.setValue("\(Payment_Update.text!)", forKey: "paymentmethod_attribute")
           objectUpdate4.setValue("\(Details_Update.text!)", forKey: "detailnotes_attribute")

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
        Details_Update.text = ExpenseAttribute[indexPath.row].detailnotes_attribute
        Payer_Update.text = ExpenseAttribute[indexPath.row].payer_attribute
        Payment_Update.text = ExpenseAttribute[indexPath.row].paymentmethod_attribute
    }
    
    func Bottomline(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: Amount_Update.frame.height - 1, width: Amount_Update.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        Amount_Update.borderStyle = UITextField.BorderStyle.none
        Amount_Update.layer.addSublayer(bottomLine)
        
        
        var bottomLine_2 = CALayer()
        bottomLine_2.frame = CGRect(x: 0.0, y: Category_Update.frame.height - 1, width: Category_Update.frame.width, height: 1.0)
        bottomLine_2.backgroundColor = UIColor.systemGray4.cgColor
        Category_Update.borderStyle = UITextField.BorderStyle.none
        Category_Update.layer.addSublayer(bottomLine_2)
        
        var bottomLine_3 = CALayer()
        bottomLine_3.frame = CGRect(x: 0.0, y: Payer_Update.frame.height - 1, width: Payer_Update.frame.width, height: 1.0)
        bottomLine_3.backgroundColor = UIColor.systemGray4.cgColor
        Payer_Update.borderStyle = UITextField.BorderStyle.none
        Payer_Update.layer.addSublayer(bottomLine_3)
        
        var bottomLine_4 = CALayer()
        bottomLine_4.frame = CGRect(x: 0.0, y: Payment_Update.frame.height - 1, width: Payment_Update.frame.width, height: 1.0)
        bottomLine_4.backgroundColor = UIColor.systemGray4.cgColor
        Payment_Update.borderStyle = UITextField.BorderStyle.none
        Payment_Update.layer.addSublayer(bottomLine_4)
        
        var bottomLine_5 = CALayer()
        bottomLine_5.frame = CGRect(x: 0.0, y: Details_Update.frame.height - 1, width: Details_Update.frame.width, height: 1.0)
        bottomLine_5.backgroundColor = UIColor.systemGray4.cgColor
        Details_Update.borderStyle = UITextField.BorderStyle.none
        Details_Update.layer.addSublayer(bottomLine_4)
    }
    
    @IBAction func CancelAct(_ sender: Any) {
        animatedismiss(desiredView: UpdateView)
    }
    
    
}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
