//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//
import Foundation
import UIKit
import FirebaseFirestore

struct Constants {
    static var adoptURL =
    "https://raw.githubusercontent.com/kirsty14/Paws4Me/main/Paws4Me/Paws4Me/Resources/JsonObject.json"
    static let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static let firestoreDatabase = Firestore.firestore()
}

struct FStoreUser {
    static var userCollectionName = "User"
    static var name = "Name"
    static var surname = "Surname"
    static var address = "Address"
    static var cellphone = "Cellphone"
    static var userID = "UserID"
}

struct FStorePet {
    static var petCollectionName = "Pet"
    static var name = "Name"
    static var breed = "Breed"
    static var age = "Age"
    static var gender = "Gender"
    static var image = "Image"
    static var userID = "UserID"
}
