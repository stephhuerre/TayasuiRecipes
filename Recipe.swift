//
//  Recipe.swift
//  TayasuiRecipes
//
//  Created by steph on 3/19/23.
//

import Foundation

enum Rating: Int, Codable, CaseIterable {
  case one = 1
  case two = 2
  case three = 3
}

extension Rating {
  static func randomRating() -> Rating? {
    return Rating.allCases.randomElement()
  }
}

@objcMembers class Recipe: NSObject, Codable {
  // MARK: - properties
  var name: String
  var imageName: String
  var ingredients: String
  var durationInMinutes: Int
  var instructions: String
  var rating: Rating

  // MARK: - computed properties
  var durationInSeconds: TimeInterval {
    return TimeInterval(durationInMinutes * 60)
  }

  var ratingInt: Int {
    return rating.rawValue
  }

  // MARK: - initializers
  init(name: String,
       imageName: String,
       ingredients: String,
       durationInMinutes: Int,
       instructions: String,
       rating: Rating) {
    self.name = name
    self.imageName = imageName
    self.ingredients = ingredients
    self.durationInMinutes = durationInMinutes
    self.instructions = instructions
    self.rating = rating
  }
}
