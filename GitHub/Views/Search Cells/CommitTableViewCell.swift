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
   
   func initCell(commit: Commits.Items) {
      fullNameLabel.text = commit.repository.full_name
      messageLabel.text = commit.commit.message
      committerLabel.text = commit.commit.committer.name
      let formatter = DateFormatter()
      formatter.dateFormat = "E, d MMM"
      commitDateLabel.text = " committed \(formatter.string(from: commit.commit.committer.commitDate))"
//      commitDateLabel.text = "commited Date"
      shaLabel.text = String(commit.sha.prefix(6))
   }
   
   func setup() {
      // settings
      backgroundColor = .systemGray6
      // subviews
      for view in [fullNameLabel, messageLabel, committerLabel, commitDateLabel, shaLabel] {
         addSubview(view)
      }
      // constraints
      fullNameLabel.setupEdgeConstraints(top: topAnchor,
                                         leading: leadingAnchor,
                                         padding: UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16))
      messageLabel.setupEdgeConstraints(top: fullNameLabel.bottomAnchor,
                                        leading: leadingAnchor,
                                        padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
      committerLabel.setupEdgeConstraints(top: messageLabel.bottomAnchor,
                                          leading: leadingAnchor,
                                          padding: UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16))
      commitDateLabel.setupEdgeConstraints(top: messageLabel.bottomAnchor,
                                          leading: committerLabel.trailingAnchor,
                                          padding: UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 16))
      shaLabel.setupEdgeConstraints(top: topAnchor,
                                    trailing: trailingAnchor,
                                    padding: UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 16))
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
