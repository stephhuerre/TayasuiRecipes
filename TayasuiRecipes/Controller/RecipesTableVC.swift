//
//  RecipesVC.swift
//  TayasuiRecipes
//
//  Created by steph on 3/19/23.
//

import UIKit

class RecipesTableVC: UITableViewController {

  // MARK: - vars
  var recipeStore: RecipeStore

  var screenTitle = "Recettes"

  // MARK: - initializers
  required init?(coder: NSCoder) {
    self.recipeStore = RecipeStore()
    super.init(coder: coder)
  }

  // MARK: - UIViewController overrides
  override func viewDidLoad() {
    super.viewDidLoad()

    title = screenTitle

    configureNavigationController()
    configureTableView()
    configureToolbar()
  }

  // MARK: - private functions
  private func updateUI() {
    tableView.reloadData()
  }

  private func configureNavigationController() {
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  private func configureTableView() {
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  private func configureToolbar() {
    let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(self.addRecipe))
    toolbarItems = [addButton]
  }

  @objc private func addRecipe() {
    recipeStore.addRandomRecipe()
    updateUI()
  }
}

// MARK: - Tableview datasource overrides
extension RecipesTableVC {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipeStore.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellId = String(describing: RecipeTCell.self)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RecipeTCell else {
      return UITableViewCell()
    }

    let recipe = recipeStore.recipes[indexPath.row]
    cell.recipe = recipe
    return cell
  }

  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      recipeStore.deleteRecipe(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}

// MARK: - Tableview delegate overrides
extension RecipesTableVC {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let recipe = recipeStore.recipes[indexPath.row]
    let recipeVC = StoryboardScene.Main.recipeVC.instantiate()
    recipeVC.recipe = recipe
    recipeVC.delegate = self
    navigationController?.pushViewController(recipeVC, animated: true)
  }
}

// MARK: - RecipeVCDelegate
extension RecipesTableVC: RecipeVCDelegate {
  func deleteRecipe(_ sender: RecipeVC) {
    guard let recipe = sender.recipe else {
      return
    }
    recipeStore.deleteRecipe(recipe)
    updateUI()
    navigationController?.popViewController(animated: true)
  }
}
