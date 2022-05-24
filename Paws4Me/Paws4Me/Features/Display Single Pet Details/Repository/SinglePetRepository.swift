//
//  SinglePetRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/29.
//

import Foundation
import Firebase
import FirebaseFirestore

class SinglePetRepository {

    // MARK: - Vars/Lets
    typealias FetchSavedPets = (Result<[Pet], LocalDatabaseError>) -> Void
    typealias SavePetResult = (Result<[Bool], FirebaseError>) -> Void

    // MARK: - Local database Function
     func isPetSaved(petName: String) -> Bool {
        var isPetSaved = false
        do {
            guard let pets = try Constants.viewContext?.fetch(Pet.fetchRequest()) else { return  false}

            for savedPet in pets where savedPet.petName == petName {
                isPetSaved = true
            }
        } catch {
            isPetSaved = false
        }
        return isPetSaved
    }

    func addPetToFirebase(name: String,
                          age: String,
                          breed: String,
                          gender: String,
                          image: String,
                          completionHandler: @escaping SaveUserResult) {

        DispatchQueue.main.async {
            if let userId = Auth.auth().currentUser?.uid {

                Constants.firestoreDatabase.collection(FStorePet.petCollectionName).document(userId).setData( [
                    FStorePet.name: name,
                    FStorePet.breed: breed,
                    FStorePet.age: breed,
                    FStorePet.gender: gender,
                    FStorePet.image: image,
                    FStorePet.userID: userId]) { (error) in
                        if error != nil {
                            completionHandler(.failure(.savingError))
                        } else {
                            completionHandler(Result.success(true))
                        }
                    }
            }
        }
    }
}
