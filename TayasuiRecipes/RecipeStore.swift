//
//  RecipeStore.swift
//  TayasuiRecipes
//
//  Created by steph on 3/20/23.
//

import Foundation

class RecipeStore {
  // MARK: - properties
  private(set) var recipes: [Recipe] {
    didSet {
      guard !firstLoading else {
        firstLoading = false
        return
      }
      saveRecipesToFileSystem()
    }
  }

  private var firstLoading = true

  // MARK: - computed properties
  var count: Int {
    return recipes.count
  }

  static var documentUrl: URL? {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    return documentDirectory?.appendingPathComponent(TayasuiConstants.FileNames.savedRecipesFileName)
  }

  // MARK: - initializers
  init() {
    self.recipes = []
    let completed = loadRecipeFromFileSystem()
    if !completed {
      loadDefaultRecipes()
    }
  }

  // MARK: - public functions
  func addRandomRecipe() {
    addRecipe(recipe: RecipeFactory.creatRandomRecipe(with: (count + 1)))
  }

  func deleteRecipe(_ recipe: Recipe) {
    guard let index = recipes.firstIndex(where: { $0 == recipe}) else {
      print("deleteRecipe: recipe to delete not in array of recipes")
      return
    }
    recipes.remove(at: index)
  }

  func deleteRecipe(at index: Int ) {
    let recipeRange = 0..<count
    guard recipeRange.contains(index) else {
      print("deleteRecipe: recipe to delete not in array of recipes")
      return
    }
    recipes.remove(at: index)
  }

  // MARK: - private functions
  private func json() throws -> Data {
    return try JSONEncoder().encode(recipes)
  }

  private func saveRecipesToFileSystem() { // should I put this in a protocol?
    guard let url = RecipeStore.documentUrl else {
      print("saveRecipes : no url to save recipes to")
      return
    }
    do {
      let data: Data = try json()
      if TayasuiConstants.Debug.savedRecipesVerbose {
        print("saveRecipes : json = \(String(data: data, encoding: .utf8) ?? "nil")")
      }
      try data.write(to: url)
    } catch let encodingError where encodingError is EncodingError {
      print("saveRecipes : couldn't encode Recipes as JSON because \(encodingError.localizedDescription)")
    } catch {
      print("saveRecipes error = \(error)")
    }
  }

  // return true if succeeded
  private func loadRecipeFromFileSystem() -> Bool {
    guard let url = RecipeStore.documentUrl,
          let jsonData = try? Data(contentsOf: url),
          let savedRecipes =  try? JSONDecoder().decode([Recipe].self, from: jsonData) else {
      return false
    }
    recipes = savedRecipes
    return true
  }

  private func loadDefaultRecipes() {
      recipes = RecipeFactory.createDefaultsRecipe()
      sortRecipes()
  }

  private func sortRecipes() {
    let recipeMutableArray = NSMutableArray(array: recipes)
    recipeMutableArray.sortRecipes()

    guard let sortedRecipes = recipeMutableArray as? [Recipe] else {
      print("addRecipe : returned array that is not an array of recipes")
      return
    }
    recipes = sortedRecipes
  }

  private func addRecipe(recipe: Recipe) {
    let recipeMutableArray = NSMutableArray(array: recipes)
    recipeMutableArray.insert(recipe)

    guard let updatedRecipes = recipeMutableArray as? [Recipe] else {
      print("addRecipe : returned array that is not an array of recipes")
      return
    }
    recipes = updatedRecipes
  }

}
