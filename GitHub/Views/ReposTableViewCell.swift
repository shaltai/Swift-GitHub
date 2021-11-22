import UIKit

class ReposTableViewCell: UITableViewCell {
   let fullNameLabel = UILabel()
   let descriptionLabel = UILabel()
   let languageLabel = UILabel()
   let stargazersCount = UILabel()
   let updatedAt = UILabel()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      
      setup()
   }
   
   func initUserCell(repo: Repos.Items) {
      fullNameLabel.text = repo.full_name
      descriptionLabel.text = repo.description
      languageLabel.text = repo.language
      stargazersCount.text = "⭐️ \(repo.stargazers_count)"
      updatedAt.text = repo.updated_at
   }
   
   func setup() {
      // settings
      backgroundColor = .systemGray6
      // subviews
      let stackView = UIStackView(arrangedSubviews: [stargazersCount, languageLabel, updatedAt])
      stackView.distribution = .equalSpacing
      addSubview(fullNameLabel)
      addSubview(descriptionLabel)
      addSubview(stackView)
      // constraints
      fullNameLabel.setupEdgeConstraints(top: topAnchor,
                                         trailing: trailingAnchor,
                                         leading: leadingAnchor,
                                         padding: UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16))
      descriptionLabel.setupEdgeConstraints(top: fullNameLabel.bottomAnchor,
                                            trailing: trailingAnchor,
                                            leading: leadingAnchor,
                                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
      stackView.setupEdgeConstraints(top: descriptionLabel.bottomAnchor,
                                     trailing: trailingAnchor,
                                     leading: leadingAnchor,
                                     padding: UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16))
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
