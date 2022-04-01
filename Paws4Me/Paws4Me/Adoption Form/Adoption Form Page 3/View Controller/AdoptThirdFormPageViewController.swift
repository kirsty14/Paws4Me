//
//  AdoptThirdFormPageViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation
import UIKit

class AdoptThirdFormPageViewControlle: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var adoptThirdFormTableView: UITableView!
    @IBOutlet weak private var progress1: UIView!
    @IBOutlet weak private var progress2: UIView!
    @IBOutlet weak private var progress3: UIView!
    @IBOutlet weak private var progress4: UIView!

    // : MARK: - Var/Lets
    private lazy var thirdFormViewModel = ThirdFormViewModel()

    // : MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpProgress()
    }

    // : MARK: - Functions
    private func setUpProgress() {
        progress1.makeCircle()
        progress2.makeCircle()
        progress3.makeCircle()
        progress4.makeCircle()
        progress1.addBorder()
        progress2.addBorder()
        progress3.addBorder()
        progress4.addBorder()
        setUpTableView()
    }

    // : MARK: - Setup tableview
    private func setUpTableView() {
        adoptThirdFormTableView?.delegate = self
        adoptThirdFormTableView?.dataSource = self
        adoptThirdFormTableView?.register(UISwitchTableViewCell.self,
                                          forCellReuseIdentifier: UISwitchTableViewCell.identifier)
        adoptThirdFormTableView?.reloadData()
    }

    // MARK: - TableView functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         thirdFormViewModel.setSection(sectionNumber: section)
        switch section {
        case 0:
            return 4
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = thirdFormViewModel.arrayForm.filter({$0.sectionIndex == indexPath.section
                                                            && $0.cellIndex == indexPath.row})

       switch indexPath.section {
       case 0:
           guard let questionTitle = cellData[0].data?.itemTitle else { return UITableViewCell() }
           let cellUISwitchCharacter = sectionCharacter(question: questionTitle, indexPath: indexPath)
           return cellUISwitchCharacter
       default:
           let cell = UITableViewCell()
           cell.textLabel?.text = "No Data"
           return cell

       }
   }

    func sectionCharacter(question: String, indexPath: IndexPath) -> UITableViewCell {
        guard let cellUISwitchGeneral = adoptThirdFormTableView?.dequeueReusableCell(withIdentifier:
                                                                                     UISwitchTableViewCell.identifier,
                                                                                     for: indexPath)
        else { return UITableViewCell() }

        cellUISwitchGeneral.textLabel?.text = question
        let switchButtonGeneral = UISwitch()
        switchButtonGeneral.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
        cellUISwitchGeneral.accessoryView = switchButtonGeneral
        return cellUISwitchGeneral
    }

    // MARK: - UISwitch event
    @objc func didChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("on")
        } else {
            print("off")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60.0
   }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40.0
   }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 10.0
   }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       switch section {
       case 0:
           return "Characteristics"
       default:
           return "Category Unknown"
       }
   }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { let headerView = UIView()
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 5, width:
        tableView.bounds.size.width, height: 30))
        headerLabel.styleSectionLabel()
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(headerLabel)
        return headerView
   }
}
