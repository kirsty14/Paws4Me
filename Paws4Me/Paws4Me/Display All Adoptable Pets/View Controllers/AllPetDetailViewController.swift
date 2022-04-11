//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class AllPetDetailViewController: UIViewController {

    // MARK: - IBOulets
    @IBOutlet weak private var petTableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var puppyIconButton: UIButton!
    @IBOutlet weak private var dogIconButton: UIButton!
    @IBOutlet weak private var kittenIconButton: UIButton!
    @IBOutlet weak private var catIconButton: UIButton!

    // MARK: - Vars/Lets
    private lazy var petDataViewModel = AllPetDataViewModel(repository: PetDataRepository(),
                                                            delegate: self)
    private var searchBarController = UISearchBar()
    fileprivate var petIconButtonArray: [UIButton] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petIconButtonArray = [puppyIconButton, dogIconButton, kittenIconButton, catIconButton]
        setupTableView()
        petDataViewModel.fetchPetDataResults()
        setUpSearchbar()
    }

    // MARK: - IBActions
    @IBAction private func catTappedButton(_ sender: UIButton) {
        petTypeFromButton(sender)
        sender.tag = 1
        petIconTappedEvent(tag: 1)
        petDataViewModel.searchPetCategoryType(_: petDataViewModel.petType)
        reloadView()
    }

    @IBAction private func kittenTappedButton(_ sender: UIButton) {
        petTypeFromButton(sender)
        sender.tag = 2
        petIconTappedEvent(tag: 2)
        petDataViewModel.searchPetCategoryType(_: petDataViewModel.petType)
        reloadView()
    }

    @IBAction private func dogTappedButton(_ sender: UIButton) {
        petTypeFromButton(sender)
        sender.tag = 3
        petIconTappedEvent(tag: 3)
        petDataViewModel.searchPetCategoryType(_: petDataViewModel.petType)
        reloadView()
    }

    @IBAction private func puppyTappedButton(_ sender: UIButton) {
        petTypeFromButton(sender)
        sender.tag = 4
        petIconTappedEvent(tag: 4)
        petDataViewModel.searchPetCategoryType(_: petDataViewModel.petType)
        reloadView()
    }

    // MARK: - Functions
    private func setupTableView() {
        petTableView.delegate = self
        petTableView.dataSource = self
        self.title = "Adoptable Animals"
    }

    private func petIconTappedEvent(tag: Int) {
        for item in self.petIconButtonArray {
            if item.tag != tag {
                item.clearPetIconBorder()
            } else {
                item.changePetIconsBorderColor()
            }
        }
    }

    private func petTypeFromButton(_ sender: UIButton) {
        let animalType = sender.titleLabel?.text ?? ""
        petDataViewModel.setPetType(petType: animalType)
    }

    private func setUpSearchbar() {
        searchBarController = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                        width: self.petTableView.bounds.width, height: 65))
        searchBarController.showsScopeBar = true
        searchBarController.scopeButtonTitles = ["Male", "Female"]
        searchBarController.selectedScopeButtonIndex = 0
        searchBarController.delegate = self
        self.petTableView.tableHeaderView = searchBarController
    }
}

// MARK: - Tableview
extension AllPetDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petDataViewModel.petCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "petAdoptCell") as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        cell.index = indexPath.row
        cell.pet = petDataViewModel.objectFilteredPet
        cell.setNeedsLayout()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PetSingleDetailsViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PetSingleDetailsViewController {
            let indexRow = indexPetSelected(tableView: petTableView)
            guard let pageItem = petDataViewModel.objectFilteredPet else { return }
            destination.setSinglePetData(petObject: pageItem, petSingleIndex: indexRow)
        }

    }

    func indexPetSelected(tableView: UITableView) -> Int {
        var indexRow = 0
        if !petDataViewModel.singleSearch || !petDataViewModel.filterSearch {
            guard let rowIndex = tableView.indexPathForSelectedRow?.row else { return 0 }
            indexRow = rowIndex
        } else {
            guard let indexPet = petDataViewModel.singlePetIndex else { return 0 }
            indexRow = indexPet
        }
        return indexRow
    }
}

// MARK: - PetViewModel Delegate
extension AllPetDetailViewController: PetViewModelDelegate {

    func reloadView() {
        petTableView.reloadData()
    }

    func showError(error: String) {
        displayAlert(alertTitle: "Something went worng",
                     alertMessage: "Could not retrieve the adoptable pets.",
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}

extension AllPetDetailViewController: UISearchBarDelegate {
    // MARK: - Search
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0 {
            petDataViewModel.setGender(gender: "male")
        } else if selectedScope == 1 {
            petDataViewModel.setGender(gender: "female")
        }
        petDataViewModel.searchPetCategoryType(_: petDataViewModel.petType)
        reloadView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        petDataViewModel.setPetSearchName(petSearchText: searchText)
        reloadView()
    }
}
