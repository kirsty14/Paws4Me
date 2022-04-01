//
//  ThirdFormViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation

class ThirdFormViewModel {

    // : MARK: - Var/Lets
    var formArray: [FormStructure] = [
        FormStructure(sectionIndex: 0, cellIndex: 0, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Do you work from home?")),
        FormStructure(sectionIndex: 0, cellIndex: 1, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Are you nervous around animals?")),
        FormStructure(sectionIndex: 0, cellIndex: 2, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Is your scedule busy??")),
        FormStructure(sectionIndex: 0, cellIndex: 3, data: CellData(cellStructure: .booleanValue,
                                                                    isChecked: false,
                                                                    itemTitle: "Are you loud?"))
    ]

    private var section: Int = 0

    func setSection(sectionNumber: Int) {
         section = sectionNumber
    }

    var arrayForm: [FormStructure] {
        return formArray
    }
}
