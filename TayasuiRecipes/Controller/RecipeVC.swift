//
//  RecipeVC.swift
//  TayasuiRecipes
//
//  Created by steph on 3/20/23.
//

import UIKit

protocol RecipeVCDelegate: AnyObject {
  func deleteRecipe(_ sender: RecipeVC)
}

class RecipeVC: UIViewController {
  // MARK: - vars
  var recipe: Recipe?
  weak var delegate: RecipeVCDelegate?

  // MARK: - iboutlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var ingredientListLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
  @IBOutlet weak var instructionsLabel: UILabel!

  // MARK: - UIViewController overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    configureRecipeUI()
    configureToolbar()
  }

  // MARK: - private funcs
  private func configureRecipeUI() {
    title = recipe?.name
    configureImageView()
    ingredientListLabel.text = recipe?.ingredients
    configureDurationLabel()
    instructionsLabel.text = recipe?.instructions
  }

  private func configureImageView() {
    if let imageName = recipe?.imageName {
      imageView.image = UIImage(named: imageName)
      imageView.isHidden = false
    } else {
      imageView.isHidden = true
    }
    imageView.roundCorners(20)
  }

  private func configureDurationLabel() {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = .full
    formatter.calendar?.locale = Locale(identifier: "fr")

    guard let timeInterval = recipe?.durationInSeconds,
          let formattedString = formatter.string(from: timeInterval) else {
      durationLabel.isHidden = true
      return
    }

    durationLabel.isHidden = false
    durationLabel.text = "Durée \(formattedString)"
  }

  private func configureToolbar() {
    let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(self.shareRecipe))

    let editButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(self.editRecipe))

    let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(self.deleteRecipe))

    let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    spacer.width = 50

    toolbarItems = [shareButton, spacer, editButton, spacer, deleteButton]
  }

  @objc private func shareRecipe() {
    print("share recipe")
  }

  @objc private func editRecipe() {
    print("edit recipe")
  }

  @objc private func deleteRecipe() {
    let alertController = UIAlertController(title: "Title",
                                            message: "Message",
                                            preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let deleteAction = UIAlertAction(title: "Destroy", style: .destructive) { _ -> Void in
      self.delegate?.deleteRecipe(self)
    }

    alertController.addAction(cancelAction)
    alertController.addAction(deleteAction)
    present(alertController, animated: true, completion: nil)
  }
}
