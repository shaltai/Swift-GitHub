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
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(repo: Repos.Items) {
      
//      fullNameLabel.attributedText = NSAttributedString(string: repo.full_name,
//                                                        attributes: Typography.h3)
//      descriptionLabel.attributedText = NSAttributedString(string: repo.description ?? "",
//                                                           attributes: Typography.p3)
//      languageLabel.attributedText = NSAttributedString(string: repo.language ?? "",
//                                                        attributes: Typography.p3)
//      stargazersCountLabel.attributedText = NSAttributedString(string: "⭐️ \(repo.stargazers_count)",
//                                                               attributes: Typography.p3)
      
//      let formatter = DateFormatter()
//      formatter.dateFormat = "E, d MMM"
//      updatedAtLabel.attributedText = NSAttributedString(string: formatter.string(from: repo.updatedAt),
//                                                         attributes: Typography.p3)
   }
   
   func setup() {
      // settings
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      
      for label in [fullNameLabel, descriptionLabel, languageLabel, stargazersCountLabel, updatedAtLabel] {
         label.numberOfLines = 0
//         label.lineBreakMode = .byCharWrapping
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
                                         padding: UIEdgeInsets(top: 16, left: 32, bottom: 8, right: 32))
      descriptionLabel.setupEdgeConstraints(trailing: trailingAnchor,
                                            bottom: stackView.topAnchor,
                                            leading: leadingAnchor,
                                            padding: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 32))
      stackView.setupEdgeConstraints(trailing: trailingAnchor,
                                     bottom: bottomAnchor,
                                     leading: leadingAnchor,
                                     padding: UIEdgeInsets(top: 0, left: 32, bottom: 24, right: 32))
   }
}
