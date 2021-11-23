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
   
//   Почему не загружается дата?
//   func formatDate(date: String, completionHandler: @escaping (String) -> Void) {
//      let formatter = DateFormatter()
//      formatter.dateFormat = "E, d MMM"
//      if let date = formatter.date(from: date) {
//         DispatchQueue.main.async {
//            let formattedDate = formatter.string(from: date)
//            print(formattedDate)
//         }
//      }
//   }
   
   func initUserCell(repo: Repos.Items) {
      fullNameLabel.text = repo.full_name
      descriptionLabel.text = repo.description
      languageLabel.text = repo.language
      stargazersCountLabel.text = "⭐️ \(repo.stargazers_count)"
      
//   Почему не загружается дата?
//      formatDate(date: repo.updated_at) { date in
//         self.updatedAt.text = date
//      }
      
      let formatter = DateFormatter()
      formatter.dateFormat = "E, d MMM"
      updatedAtLabel.text = formatter.string(from: repo.updatedAt)
   }
   
   func setup() {
      // settings
      backgroundColor = .systemGray6
      // subviews
      let stackView = UIStackView(arrangedSubviews: [stargazersCountLabel, languageLabel, updatedAtLabel])
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
