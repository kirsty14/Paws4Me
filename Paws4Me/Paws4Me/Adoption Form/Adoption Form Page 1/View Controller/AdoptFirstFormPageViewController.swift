//
//  AdoptFirstFormPageViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation
import UIKit

class AdoptFirstFormPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // : MARK: - IBOutlet
    @IBOutlet weak private var adoptFirstFormTableView: UITableView?
    @IBOutlet weak private var progress1: UIView!
    @IBOutlet weak private var progress3: UIView!
    @IBOutlet weak private var progress2: UIView!
    @IBOutlet weak private var progress4: UIView!

    // : MARK: - Var/Lets
    private lazy var firstFormViewModel = FirstFormViewModel()
    private var textFields = [UITextField]()
    private var uiSwitches = [UISwitch]()
    private var indexTextfield = 0
    private var indexUISwitch = 0

    // : MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpProgress()
    }

    // : MARK: - IBAction
    @IBAction func form2NextButton(_ sender: Any) {

        var indexTextfield = 0

        while textFields.count != indexTextfield {
            if let textField = self.textFieldForTag( tag: indexTextfield ) {
                guard let textfieldValue = textField.text else { return }
                var cellData = firstFormViewModel.arrayForm.filter({$0.cellIndex == indexTextfield})
                cellData[0].data?.itemValue = textfieldValue
                print( cellData[0] )
                indexTextfield += 1
            }
    }
        var indexSwitch = 0
        while uiSwitches.count != indexSwitch {
            if let uiSwitch = self.uiSwitchForTag(tag: indexSwitch) {
                var cellData = firstFormViewModel.arrayForm.filter({$0.cellIndex == indexSwitch})
                cellData[0].data?.itemValue = uiSwitch.isOn.description
                print( cellData[0] )
                indexSwitch += 1
            }
    }
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

    private  func textFieldForTag( tag: Int ) -> UITextField? {
        return self.textFields.filter({ $0.tag == tag }).first
    }

    private  func uiSwitchForTag( tag: Int ) -> UISwitch? {
        return self.uiSwitches.filter({ $0.tag == tag }).first
    }

   private func setUpTableView() {
        adoptFirstFormTableView?.delegate = self
        adoptFirstFormTableView?.dataSource = self
        adoptFirstFormTableView?.register(TextBoxTableViewCell.self,
                                          forCellReuseIdentifier: TextBoxTableViewCell.identifier)
        adoptFirstFormTableView?.register(UISwitchTableViewCell.self,
                                          forCellReuseIdentifier: UISwitchTableViewCell.identifier)
        adoptFirstFormTableView?.reloadData()
    }

    // MARK: - TableView functions
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         firstFormViewModel.setSection(sectionNumber: section)
        switch section {
        case 0, 1:
            return firstFormViewModel.arrayForm.filter({$0.sectionIndex == section}).count
        default:
            return 1
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
            return "Contact"
        case 1:
            return "General"
        default:
            return "Category Unknown"
        }
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellData = firstFormViewModel.arrayForm.filter({$0.sectionIndex == indexPath.section
                                                            && $0.cellIndex == indexPath.row})
        switch indexPath.section {
        case 0:
            guard let questionTitle = cellData[0].data?.itemTitle else { return UITableViewCell() }
            guard let questionPlaceholder = cellData[0].data?.itemPlaceholder else { return UITableViewCell() }
            let cellTextbox = sectionContact(question: questionTitle,
                                             indexPath: indexPath,
                                             placeholder: questionPlaceholder)
            return cellTextbox
        case 1:
            if cellData.count == 0 {
                return UITableViewCell()
            } else {
                guard let questionTitle = cellData[0].data?.itemTitle else { return UITableViewCell() }
                let cellUISwitch = sectionGeneral(question: questionTitle, indexPath: indexPath)
                return cellUISwitch
            }
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "No Data"
            return cell
        }
    }

    // : MARK: - Custom cell generation
    func sectionContact(question: String, indexPath: IndexPath, placeholder: String) -> UITableViewCell {
        guard let cellTextbox = adoptFirstFormTableView?.dequeueReusableCell(withIdentifier:
                                                                             TextBoxTableViewCell.identifier,
                                                                             for: indexPath)
        else { return UITableViewCell() }

        cellTextbox.textLabel?.text =  question
        let textfield = createTextField(question: placeholder)
        cellTextbox.contentView.addSubview(textfield)
        return cellTextbox
    }

    func sectionGeneral(question: String, indexPath: IndexPath) -> UITableViewCell {
        guard let cellUISwitchGeneral = adoptFirstFormTableView?.dequeueReusableCell(withIdentifier:
                                                                                     UISwitchTableViewCell.identifier,
                                                                                     for: indexPath)
        else { return UITableViewCell() }
        cellUISwitchGeneral.textLabel?.text = question
        let switchButtonGeneral = UISwitch()
        switchButtonGeneral.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
        switchButtonGeneral.tag = indexUISwitch
        cellUISwitchGeneral.accessoryView = switchButtonGeneral
        self.uiSwitches.append( switchButtonGeneral )
        indexUISwitch += 1
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

    // MARK: - UI Creation
    func createTextField(question: String) -> UITextField {
        let textField =  UITextField(frame: CGRect(x: 150, y: 10, width: 200, height: 40))
        textField.placeholder = question
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self as? UITextFieldDelegate
        textField.tag = indexTextfield
        self.textFields.append( textField )
        indexTextfield += 1
        return textField
    }

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 5, width:
        tableView.bounds.size.width, height: 30))
        headerLabel.styleSectionLabel()
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(headerLabel)
        return headerView
    }
}
