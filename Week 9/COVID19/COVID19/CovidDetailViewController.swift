//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by 이재웅 on 2021/10/15.
//

import UIKit

class CovidDetailViewController: UITableViewController {
    @IBOutlet weak var newCaseCell: UILabel!
    @IBOutlet weak var totalCaseCell: UILabel!
    @IBOutlet weak var recoveredCell: UILabel!
    @IBOutlet weak var deathCell: UILabel!
    @IBOutlet weak var percentageCell: UILabel!
    @IBOutlet weak var overseasInflowCell: UILabel!
    @IBOutlet weak var regionalOutbreakCell: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
