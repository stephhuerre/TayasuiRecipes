//
//  RecipeTCell.swift
//  TayasuiRecipes
//
//  Created by steph on 3/19/23.
//

import UIKit

class RecipeTCell: UITableViewCell {

  // MARK: - vars
  var recipe: Recipe? {
    didSet {
      updateUI()
    }
  }

  // MARK: - ibOutlets
  @IBOutlet weak var ratingStackView: UIStackView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!

  // MARK: - override funcs
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    updateUI()
  }

  override func prepareForReuse() {
    recipe = nil
  }

  // MARK: - private funcs
  private func updateUI() {
    updateRatingStackView()
    guard let recipe = recipe else {
      nameLabel.text = nil
      durationLabel.text = nil
      return
    }
    nameLabel.text = recipe.name
    updateDuration()
  }

  private func updateDuration() {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.calendar?.locale = Locale(identifier: "fr")
    formatter.unitsStyle = .abbreviated

    guard let recipe = recipe,
          let formattedString = formatter.string(from: recipe.durationInSeconds) else {
      durationLabel.isHidden = true
      return
    }
    durationLabel.isHidden = false
    durationLabel.text = formattedString
  }

  private func updateRatingStackView() {
    ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    guard let rating = recipe?.ratingInt else {
      return
    }
    for _ in 0..<rating {
      let starView = UIImageView(image: UIImage(systemName: "star"))
      starView.tintColor = .secondaryLabel
      ratingStackView.addArrangedSubview(starView)
    }

  }
}
