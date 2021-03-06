//
//  AdoptionModel.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import Foundation

struct AdoptPet: Codable {
    let count: Int?
    var page: [Page]?
}

struct Page: Codable {
    let age: String?
    let center: Center?
    let color, desc: String?
    let petId: Int?
    let name: String?
    let animalImage: String?
    let sex: String?
    let animalSpeciesBreed: SpeciesBreed?
    private enum CodingKeys: String, CodingKey {
        case age
        case center
        case color
        case desc
        case petId = "id"
        case name
        case animalImage = "pic_url"
        case sex
        case animalSpeciesBreed = "species_breed"
    }
}

enum Sex: String, Codable {
    case empty = ""
    case female = "female"
    case male = "male"
}

enum SpeciesName: String, Codable {
    case cat = "Cat"
    case dog = "Dog"
    case kitten = "Kitten"
    case puppy = "Puppy"
}

struct SpeciesBreed: Codable {
    let petBreedName: String?
    let speciesID: Int?
    let petSpecies: String?
    let petYouthName: String?
    enum CodingKeys: String, CodingKey {
        case petBreedName = "breed_name"
        case speciesID = "id"
        case petSpecies = "species_name"
        case petYouthName = "youth_name"
    }
}
