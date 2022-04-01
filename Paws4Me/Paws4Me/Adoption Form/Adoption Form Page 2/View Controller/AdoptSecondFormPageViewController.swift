//
//  AdoptSecondFormPageViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation
import UIKit

class AdoptSecondFormPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // : MARK: - IBOutlet
    @IBOutlet weak private var adoptSecondFormTableView: UITableView!
    @IBOutlet weak private var progress1: UIView!
    @IBOutlet weak private var progress2: UIView!
    @IBOutlet weak private var progress4: UIView!
    @IBOutlet weak private var progress3: UIView!

    // : MARK: - Var/Lets
    private lazy var secondFormViewModel = SecondFormViewModel()

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

    private func setUpTableView() {
        adoptSecondFormTableView?.delegate = self
        adoptSecondFormTableView?.dataSource = self
        adoptSecondFormTableView?.register(ImageTableViewCell.self,
                                           forCellReuseIdentifier: ImageTableViewCell.identifier)
        adoptSecondFormTableView?.reloadData()
    }

    // MARK: - TableView functions
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         secondFormViewModel.setSection(sectionNumber: section)
        switch section {
        case 0:
            return 4
        case 1:
            return 5
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = secondFormViewModel.arrayForm.filter({$0.sectionIndex == indexPath.section
                                                             && $0.cellIndex == indexPath.row})
       switch indexPath.section {
       case 0:
          guard var cellImageHome = adoptSecondFormTableView?.dequeueReusableCell(withIdentifier:
                                                                                  ImageTableViewCell.identifier,
                                                                                  for: indexPath) as? ImageTableViewCell
           else { return UITableViewCell() }
           guard let setImage = cellData[0].data?.itemImage?.rawValue else { return UITableViewCell() }
           guard let setName = cellData[0].data?.itemName else { return UITableViewCell() }

           cellImageHome = setHomeCellUI(setName: setName,
                                         setImage: setImage,
                                         cellData: cellData,
                                         indexPath: indexPath,
                                         cellImageHome: cellImageHome)
           return cellImageHome
       case 1:
           guard var cellAway = adoptSecondFormTableView?.dequeueReusableCell(withIdentifier:
                                                                              ImageTableViewCell.identifier,
                                                                              for: indexPath) as? ImageTableViewCell
           else { return UITableViewCell() }
           guard let setImage = cellData[0].data?.itemImage?.rawValue else { return UITableViewCell() }
           guard let setName = cellData[0].data?.itemName else { return UITableViewCell() }

           cellAway = setAwayCellUI(setName: setName,
                                    setImage: setImage,
                                    cellData: cellData, indexPath:
                                        indexPath,
                                    cellAway: cellAway)
           return cellAway
       default:
           let cell = UITableViewCell()
           cell.textLabel?.text = "No Data"
           return cell
       }
   }

    func setHomeCellUI(setName: String, setImage: String, cellData: [FormStructure],
                       indexPath: IndexPath, cellImageHome: ImageTableViewCell) -> ImageTableViewCell {
        switch cellData[0].data?.itemImage {
        case .titleImg:
            cellImageHome.textLabel?.text = cellData[0].data?.itemTitle
        case .farm:
            cellImageHome.textLabel?.text = setName
            cellImageHome.imageView?.image = UIImage(named: setImage)
        case .flat:
            cellImageHome.textLabel?.text = setName
            cellImageHome.imageView?.image = UIImage(named: setImage)
        case .home:
            cellImageHome.textLabel?.text = setName
            cellImageHome.imageView?.image = UIImage(named: setImage)
        default:
            cellImageHome.textLabel?.text = setName
            cellImageHome.imageView?.image = UIImage(named: setImage)
        }
        return cellImageHome
    }

    func setAwayCellUI(setName: String, setImage: String, cellData: [FormStructure],
                       indexPath: IndexPath, cellAway: ImageTableViewCell) -> ImageTableViewCell {
        switch cellData[0].data?.itemImage {
        case.titleImg:
            cellAway.textLabel?.text = cellData[0].data?.itemTitle
        case .family:
            cellAway.textLabel?.text = cellData[0].data?.itemTitle
            cellAway.imageView?.image = UIImage(named: setImage)
            cellAway.textLabel?.text = setName
        case .kennel:
            cellAway.imageView?.image = UIImage(named: setImage)
            cellAway.textLabel?.text = setName
        case .petSitter:
            cellAway.imageView?.image = UIImage(named: setImage)
            cellAway.textLabel?.text = setName
        case .takeWith:
            cellAway.imageView?.image = UIImage(named: setImage)
            cellAway.textLabel?.text = setName
        default:
            cellAway.imageView?.image = UIImage(named: setImage)
            cellAway.textLabel?.text = setName
        }
        return cellAway
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70.0
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
           return "Home"
       case 1:
           return "Away"
       default:
           return "Category Unknown"
       }
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
