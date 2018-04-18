//
//  ExpensesPieChartViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 16/04/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit
import Charts

class ExpensesPieChartViewController: UIViewController {

    @IBOutlet weak var barCharView: BarChartView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setChart()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func setChart() {
        
        var dataEntries: [BarChartDataEntry] = []
        var countFood = 0
        var countEducation = 0
        var countRecreation = 0
        var countOthers = 0
        _ = [Expense]()
        
        if let expenses = ExpenseManager.shared.loadExpenses(with: context) {
            
            for expense in expenses {
                switch expense.category {
                case 1:
                    countFood += 1
                case 2:
                    countEducation += 1
                case 3:
                    countRecreation += 1
                default:
                    countOthers += 1
                }
            }
            
            for i in 0..<4 {
                
                switch i {
                case 1:
                    let dataEntry = BarChartDataEntry(x: 2.0, y: Double(countFood))
                    dataEntries.append(dataEntry)
                case 2:
                    let dataEntry = BarChartDataEntry(x: 3.0, y: Double(countEducation))
                    dataEntries.append(dataEntry)
                case 3:
                    let dataEntry = BarChartDataEntry(x: 4.0, y: Double(countRecreation))
                    dataEntries.append(dataEntry)
                default:
                    let dataEntry = BarChartDataEntry(x: 1.0, y: Double(countOthers))
                    dataEntries.append(dataEntry)
                }
            }
        }

        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Categorias")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.red,UIColor.orange,UIColor.green,UIColor.blue] //ChartColorTemplates.colorful()
        barCharView.data = chartData
        barCharView.noDataText = "Não existem depesas cadastradas para o mês e ano selecionados."
    }
}
