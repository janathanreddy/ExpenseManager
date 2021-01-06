//
//  InputViewController.swift
//  ExpenseManager
//
//  Created by Janarthan Subburaj on 06/01/21.
//

import UIKit
import CoreData

class InputViewController: UIViewController {

    @IBOutlet weak var SegMentControll: UISegmentedControl!
    @IBOutlet weak var ViewForInput: UIView!
    @IBOutlet weak var PayerDetail: UITextField!
    @IBOutlet weak var IncomeAmount: UITextField!
    @IBOutlet weak var CategoryType: UITextField!
    @IBOutlet weak var PaymentMethod: UITextField!
    @IBOutlet weak var anyDetailsNotes: UITextView!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    
    var ExpenseAttribute = [IncomeExpense]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var date_1:String?
    var time:String?
    var segmentindex:Int!
    var remaind:Float!
    var incomeamount:String!
    var expenseamount:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentindex = 0
        remaind = 0.0
        ButtomLine()
        TodayDate()
        SaveTime()
    }

    @IBAction func SegmentControl(_ sender: UISegmentedControl) {
        
        print("segmentindex: \(sender.selectedSegmentIndex)")
        segmentindex = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 1{
            IncomeAmount.placeholder = "Expense Amount"
            SegMentControll.selectedSegmentTintColor = UIColor.systemRed
            ViewForInput.backgroundColor = UIColor.systemYellow

            
        }else{
            IncomeAmount.placeholder = "Income Amount"
            SegMentControll.selectedSegmentTintColor = UIColor.systemGreen
            ViewForInput.backgroundColor = UIColor.systemGreen

        }
    }
    func ButtomLine(){
        ViewForInput.layer.cornerRadius = 10
        SaveBtn.layer.cornerRadius = 5
        CancelBtn.layer.cornerRadius = 5
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: PayerDetail.frame.height - 1, width: PayerDetail.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        PayerDetail.borderStyle = UITextField.BorderStyle.none
        PayerDetail.layer.addSublayer(bottomLine)
        
        var bottomLine_2 = CALayer()
        bottomLine_2.frame = CGRect(x: 0.0, y: IncomeAmount.frame.height - 1, width: IncomeAmount.frame.width, height: 1.0)
        bottomLine_2.backgroundColor = UIColor.systemGray4.cgColor
        IncomeAmount.borderStyle = UITextField.BorderStyle.none
        IncomeAmount.layer.addSublayer(bottomLine_2)
        
        var bottomLine_3 = CALayer()
        bottomLine_3.frame = CGRect(x: 0.0, y: CategoryType.frame.height - 1, width: CategoryType.frame.width, height: 1.0)
        bottomLine_3.backgroundColor = UIColor.systemGray4.cgColor
        CategoryType.borderStyle = UITextField.BorderStyle.none
        CategoryType.layer.addSublayer(bottomLine_3)
        
        var bottomLine_4 = CALayer()
        bottomLine_4.frame = CGRect(x: 0.0, y: PaymentMethod.frame.height - 1, width: PaymentMethod.frame.width, height: 1.0)
        bottomLine_4.backgroundColor = UIColor.systemGray4.cgColor
        PaymentMethod.borderStyle = UITextField.BorderStyle.none
        PaymentMethod.layer.addSublayer(bottomLine_4)
        
        anyDetailsNotes.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        anyDetailsNotes.layer.borderWidth = 1.0
        anyDetailsNotes.layer.cornerRadius = 5

    }
    
    
    
    
    func loadInputs(){
        
        let Task = IncomeExpense(context: context)
        Task.amount_attribute = IncomeAmount.text
        Task.payer_attribute = PayerDetail.text
        Task.category_attribute = CategoryType.text
        Task.paymentmethod_attribute = PaymentMethod.text
        Task.detailnotes_attribute = anyDetailsNotes.text
        Task.date_attribute = date_1
        Task.time_attribute = time
        if segmentindex == 1{
            Task.incomeorexpense_attribute = "Expense"
        }else{
            Task.incomeorexpense_attribute = "Income"
        }
        do{
            try context.save()
            print("Save Sueccessfully \(Task)")
           
        }catch {
            print("Error saving Task with \(error)")
        }
        
        self.ExpenseAttribute.append(Task)
    }
    
    @IBAction func CancelAct(_ sender: Any) {
        ClearText()
    }
    
    @IBAction func SaveAct(_ sender: Any) {
        loadInputs()
        let alert = UIAlertController(title: "Alert", message: "Data Save Successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        ClearText()
    }
    func ClearText(){
        IncomeAmount.text = ""
        PayerDetail.text = ""
        CategoryType.text = ""
        PaymentMethod.text = ""
        anyDetailsNotes.text = ""
        date_1?.removeAll()
        time?.removeAll()

    }
    func TodayDate(){
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        let date = Date()
        date_1 = dateFormatter.string(from: date)
    }
    func SaveTime(){
        let dateformat=DateFormatter()
        dateformat.dateStyle = .none
        dateformat.timeStyle = .medium
        let time_1 = Date()
        time = dateformat.string(from: time_1)
    }
    
}
