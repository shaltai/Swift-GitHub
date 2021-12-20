import UIKit

class RepoTableViewCell: UITableViewCell {
   let fullNameLabel = UILabel()
   let descriptionLabel = UILabel()
   let languageLabel = UILabel()
   let stargazersCountLabel = UILabel()
   let updatedAtLabel = UILabel()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   func initCell(repo: Repos.Items) {

      fullNameLabel.text = repo.full_name
      descriptionLabel.text = repo.description
      languageLabel.text = repo.language
      stargazersCountLabel.text = "⭐️ \(repo.stargazers_count)"
      
      let formatter = DateFormatter()
      formatter.dateFormat = "E, d MMM"
      updatedAtLabel.text = formatter.string(from: repo.updatedAt)
   }
   
   func setup() {
      // settings
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      
      for label in [fullNameLabel, descriptionLabel, languageLabel, stargazersCountLabel, updatedAtLabel] {
         label.numberOfLines = 0
         label.lineBreakMode = .byCharWrapping
      }
      // subviews
      let stackView = UIStackView(arrangedSubviews: [stargazersCountLabel, languageLabel, updatedAtLabel])
      stackView.distribution = .equalSpacing
      addSubview(fullNameLabel)
      addSubview(descriptionLabel)
      addSubview(stackView)
      // constraints
      fullNameLabel.setupEdgeConstraints(top: topAnchor,
                                         trailing: trailingAnchor,
                                         bottom: descriptionLabel.topAnchor,
                                         leading: leadingAnchor,
                                         padding: UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16))
      descriptionLabel.setupEdgeConstraints(trailing: trailingAnchor,
                                            bottom: stackView.topAnchor,
                                            leading: leadingAnchor,
                                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
      stackView.setupEdgeConstraints(trailing: trailingAnchor,
                                     bottom: bottomAnchor,
                                     leading: leadingAnchor,
                                     padding: UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16))
   }
}
