//
//  ViewController.swift
//  SalaryCalculator
//
//  Created by Thaowpsta Saiid on 30/04/2026.
//

import UIKit

class Person {
    var baseSalary: Double
    
    init(baseSalary: Double) {
        self.baseSalary = baseSalary
    }
    
    func getSalary() -> Double {
        return baseSalary
    }
}

class Employee: Person {
    override func getSalary() -> Double {
        return super.getSalary() * 10
    }
}

class Manager: Person {
    override func getSalary() -> Double {
        return super.getSalary() * 1000
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func calculateEmployeeSalary(_ sender: UIButton) {
        guard let salaryText = salaryTextField.text, let base = Double(salaryText) else {
            resultLabel.text = "Please enter a valid number."
            return
        }
        
        let employee = Employee(baseSalary: base)
        resultLabel.text = "Employee Salary: $\(employee.getSalary())"
    }
    
    @IBAction func calculateManagerSalary(_ sender: UIButton) {
        guard let salaryText = salaryTextField.text, let base = Double(salaryText) else {
            resultLabel.text = "Please enter a valid number."
            return
        }
        
        let manager = Manager(baseSalary: base)
        resultLabel.text = "Manager Salary: $\(manager.getSalary())"
    }
    
}

