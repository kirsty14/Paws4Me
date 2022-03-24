//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class AllPetDetailViewController: UIViewController, UISearchBarDelegate {

    // MARK: - IBOulets
    @IBOutlet weak private var petTableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!

    // MARK: - Vars/Lets
    private lazy var petDataViewModel = GetAllPetDataViewModel(repository: GetPetDataRepository(),
                                                               delegate: self)
    private lazy var singlePetInViewModel = SinglePetViewModel()
    private var searchBarController = UISearchBar()
    private var animalType = ""

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        petDataViewModel.fetchPetDataResults()
        setUpSearchbar()
    }

    // MARK: - IBActions
    @IBAction private func catTappedButton(_ sender: UIButton) {
        getPetTypeFromButton(sender)
        sender.changePetIconsColor()
        petDataViewModel.searchPetCategoryType(_: animalType)
        reloadView()
    }
    @IBAction private func kittenTappedButton(_ sender: UIButton) {
        getPetTypeFromButton(sender)
        sender.changePetIconsColor()
        petDataViewModel.searchPetCategoryType(_: animalType)
        reloadView()
    }
    @IBAction private func dogTappedButton(_ sender: UIButton) {
        getPetTypeFromButton(sender)
        sender.changePetIconsColor()
        petDataViewModel.searchPetCategoryType(_: animalType)
        reloadView()
    }
    @IBAction private func puppyTappedButton(_ sender: UIButton) {
        getPetTypeFromButton(sender)
        sender.changePetIconsColor()
        petDataViewModel.searchPetCategoryType(_: animalType)
        reloadView()
    }

    // MARK: - Functions
    private func setupTableView() {
        petTableView.delegate = self
        petTableView.dataSource = self
        self.title = "Adoptable Animals"
    }

    func getPetTypeFromButton(_ sender: UIButton) {
        animalType = sender.titleLabel?.text ?? ""
    }

    func setUpSearchbar() {
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
        petDataViewModel.getPetCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "petAdoptCell") as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        cell.index = indexPath.row
        cell.pet = petDataViewModel.getFilteredPetObject()
        cell.setNeedsLayout()
        cell.backgroundColor = UIColor.myAppTan
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PetSingleDetailsViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PetSingleDetailsViewController {
            let indexRow = petDataViewModel.getIndexPetSelected(tableView: petTableView)
            guard let pageItem = petDataViewModel.getFilteredPetObject() else { return }
            destination.setSinglePetObject(petObject: pageItem)
            destination.setSelectedPetIndex(indexPet: indexRow)
        }

    }

    // MARK: - Search
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0 {
            petDataViewModel.setGender(gender: "male")
        } else if selectedScope == 1 {
            petDataViewModel.setGender(gender: "female")
        }
        petDataViewModel.searchPetCategoryType(_: animalType)
        reloadView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        petDataViewModel.searchSpecificPet(petSearchText: searchText)
        reloadView()
    }
}

// MARK: - ViewModel Delegate
extension AllPetDetailViewController: PetViewModelDelegate {

    func reloadView() {
        petTableView.reloadData()
    }

    func show(error: String) {
        displayAlert(alertTitle: "Something went worng",
                     alertMessage: "Could not retrieve the adoptable pets.",
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}
