//
//  CategoryViewController.swift
//  Money Flow
//
//  Created by Алия Гиниятова on 05.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    private let detailTableViewCellID = "DetailTableViewCell"
    var backgroundColor: UIColor!
    var categoryName: String!
    
    private let tempData: [ExpenseInfo] = [
        ExpenseInfo(name: "Новые шины", date: "21.05.2020", icon: "⚙️", cost: 1200),
        ExpenseInfo(name: "Автомойка", date: "21.05.2020", icon: "🚿", cost: 15),
        ExpenseInfo(name: "Автосервис", date: "21.05.2020", icon: "🛠", cost: 900)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        categoryLabel.text = categoryName
        mainView.backgroundColor = backgroundColor
        panelView.layer.cornerRadius = 20
        panelView.dropShadow()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        let addScreenViewController = storyboard?.instantiateViewController(identifier: "AddScreenViewController") as? AddScreenViewController ?? AddScreenViewController()
        addScreenViewController.backgroundColor = backgroundColor
        addScreenViewController.categoryName = categoryLabel.text
        navigationController?.pushViewController(addScreenViewController, animated: true)
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCellID) as? DetailTableViewCell ?? DetailTableViewCell()
        cell.setData(tempData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}

struct ExpenseInfo {
    let name: String
    let date: String //#warning: как хранить дату?
    let icon: String
    let cost: CGFloat
    
    func getPrettyStringForCost() -> String {
        let costArray = Array(String(Int(cost)))
        var prettyString = ""
        for (i, digit) in costArray.reversed().enumerated() {
            prettyString = String(digit) + prettyString
            if i % 3 == 2 {
                prettyString = "," + prettyString
            }
        }
        if prettyString.starts(with: ",") {
            prettyString.removeFirst()
        }
        return "$" + prettyString
    }
}

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
