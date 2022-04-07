//
//  FirstFormViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation

class FirstFormViewModel {

    // : MARK: - Var/Lets
    private var formArray: [FormStructure] = [
        FormStructure(sectionIndex: 0, cellIndex: 0, data: CellData(cellStructure: .inputValue,
                                                                    itemTitle: "Cellphone:",
                                                                    itemPlaceholder: "Enter Cellphone")),
        FormStructure(sectionIndex: 0, cellIndex: 1, data: CellData(cellStructure: .inputValue,
                                                                    itemTitle: "Address:",
                                                                    itemPlaceholder: "Enter Address")),
        FormStructure(sectionIndex: 0, cellIndex: 2, data: CellData(cellStructure: .inputValue,
                                                                    itemTitle: "Email:",
                                                                    itemPlaceholder: "Enter Email")),

        FormStructure(sectionIndex: 1, cellIndex: 0, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Is this pet for you?")),
        FormStructure(sectionIndex: 1, cellIndex: 1, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Have you ever owned a pet?")),
        FormStructure(sectionIndex: 1, cellIndex: 2, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Do you have children?"))
    ]

    private var section: Int = 0

    func setSection(sectionNumber: Int) {
         section = sectionNumber
    }

    var arrayForm: [FormStructure] {
        return formArray
    }
}
