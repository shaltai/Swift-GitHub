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
      fullNameLabel.attributedText = NSMutableAttributedString(string: commit.repository.full_name).setupAttributes(style: .heading(level: .h5),
                                                                                                                    align: .left,
                                                                                                                    color: .black)
      messageLabel.attributedText = NSMutableAttributedString(string: commit.commit.message).setupAttributes(style: .paragraph(level: .p3),
                                                                                                             align: .left,
                                                                                                             color: .black)
      committerLabel.attributedText = NSMutableAttributedString(string: commit.commit.committer.name).setupAttributes(style: .paragraph(level: .p3),
                                                                                                                      align: .left,
                                                                                                                      color: .systemGray)
      let formatter = DateFormatter()
      formatter.dateFormat = "E, d MMM"
      let dateString = " committed \(formatter.string(from: commit.commit.committer.commitDate))"
      commitDateLabel.attributedText = NSMutableAttributedString(string: dateString).setupAttributes(style: .paragraph(level: .p3),
                                                                                                     align: .left,
                                                                                                     color: .systemGray)
      shaLabel.attributedText = NSMutableAttributedString(string: "\(commit.sha.prefix(6))").setupAttributes(style: .heading(level: .h5),
                                                                                                             align: .left,
                                                                                                             color: .systemGray)
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
      shaLabel.setupEdgeConstraints(top: fullNameLabel.topAnchor,
                                    trailing: contentView.trailingAnchor,
                                    bottom: fullNameLabel.bottomAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
   }
}
