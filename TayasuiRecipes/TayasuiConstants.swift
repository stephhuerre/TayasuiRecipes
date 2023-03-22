//
//  TayasuiRecipes.swift
//  TayasuiRecipes
//
//  Created by steph on 3/19/23.
//

import Foundation

enum TayasuiConstants {}

extension TayasuiConstants {
  struct FileNames {
    static let savedRecipesFileName = "recipes.txt"
  }

  struct NewRecipe {
    static let minDuration = 30
    static let maxDuration = 200
  }

  struct Debug {
    static let savedRecipesVerbose = false
  }
}
