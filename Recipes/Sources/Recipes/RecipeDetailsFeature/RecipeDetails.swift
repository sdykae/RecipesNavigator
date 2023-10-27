//
//  RecipeDetails.swift
//  
//
//  Created by sdykae on 10/26/23.
//

public struct RecipeDetails: Equatable, Hashable {
    public let id: Int
    public let name: String
    public let ingredients: [DetailedIngredient]
    public let steps: [String]
    public let timers: [Int]
    public let imageURL: String
    public let originalURL: String
    public let location: Location

    public struct DetailedIngredient: Equatable,Hashable {
        public let quantity: String
        public let name: String
        public let type: String
    }

    public struct Location: Equatable, Hashable {
        public let latitude: Double
        public let longitude: Double
    }
}
