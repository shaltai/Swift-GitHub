import UIKit

class CommitTableViewCell: UITableViewCell {
   let fullNameLabel = UILabel()
   let messageLabel = UILabel()
   let committerLabel = UILabel()
   let commitDateLabel = UILabel()
   let shaLabel = UILabel()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(commit: Commits.Items) {
      fullNameLabel.text = commit.repository.full_name
      messageLabel.text = commit.commit.message
      committerLabel.text = commit.commit.committer.name
      let formatter = DateFormatter()
      formatter.dateFormat = "E, d MMM"
      commitDateLabel.text = " committed \(formatter.string(from: commit.commit.committer.commitDate))"
      shaLabel.text = String(commit.sha.prefix(6))
   }
   
   func setup() {
      // settings
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      shaLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: .horizontal)
      shaLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 260), for: .horizontal)
      // subviews
      let view = UIView()
      contentView.addSubview(view)
      contentView.addSubview(shaLabel)
      for label in [fullNameLabel, messageLabel, committerLabel, commitDateLabel] {
         label.numberOfLines = 0
         label.lineBreakMode = .byCharWrapping
         view.addSubview(label)
      }
      // constraints
      view.setupEdgeConstraints(top: contentView.topAnchor,
                                trailing: shaLabel.leadingAnchor,
                                bottom: contentView.bottomAnchor,
                                leading: contentView.leadingAnchor,
                                padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 8))
      fullNameLabel.setupEdgeConstraints(top: view.topAnchor,
                                         trailing: view.trailingAnchor,
                                         leading: view.leadingAnchor,
                                         padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
      messageLabel.setupEdgeConstraints(top: fullNameLabel.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        leading: view.leadingAnchor,
                                        padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
      committerLabel.setupEdgeConstraints(top: messageLabel.bottomAnchor,
                                          bottom: view.bottomAnchor,
                                          leading: view.leadingAnchor,
                                          padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
      commitDateLabel.setupEdgeConstraints(top: committerLabel.topAnchor,
                                           trailing: view.trailingAnchor,
                                           bottom: committerLabel.bottomAnchor,
                                           leading: committerLabel.trailingAnchor)
//      shaLabel.firstBaselineAnchor.constraint(equalTo: fullNameLabel.firstBaselineAnchor).isActive = true
      shaLabel.setupEdgeConstraints(top: fullNameLabel.topAnchor,
                                    trailing: contentView.trailingAnchor,
                                    bottom: fullNameLabel.bottomAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
