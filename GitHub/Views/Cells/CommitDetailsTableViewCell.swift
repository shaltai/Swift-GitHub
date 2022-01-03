import UIKit

class CommitDetailsTableViewCell: UITableViewCell {
   let commitStackView = UIStackView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(details: CommitDetails) {
      for view in commitStackView.subviews {
         view.removeFromSuperview()
      }
      
      for file in 0...details.files.count - 1 {
         // Wrapper view
         let view = UIView()
         view.backgroundColor = file % 2 == 0 ? .systemGray6 : .systemGray4
         // Labels settings
         let fileName = UILabel()
         fileName.numberOfLines = 0
         fileName.attributedText = NSMutableAttributedString(string: details.files[file].filename).setupAttributes(style: .heading(level: .h5),
                                                                                                                   align: .left,
                                                                                                                   color: .black)
         let patch = UILabel()
         patch.numberOfLines = 0
         patch.attributedText = NSMutableAttributedString(string: details.files[file].patch ?? "").setupAttributes(style: .paragraph(level: .p3),
                                                                                                                   align: .left,
                                                                                                                   color: .black)
         // subviews
         view.addSubview(fileName)
         view.addSubview(patch)
         commitStackView.addArrangedSubview(view)
         // constraints
         fileName.setupEdgeConstraints(top: view.topAnchor,
                                       trailing: view.trailingAnchor,
                                       bottom: patch.topAnchor,
                                       leading: view.leadingAnchor,
                                       padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
         patch.setupEdgeConstraints(trailing: view.trailingAnchor,
                                    bottom: view.bottomAnchor,
                                    leading: view.leadingAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
      }
   }
         
   func setup() {
      // Stack settings
      commitStackView.axis = .vertical
      commitStackView.distribution = .equalSpacing
      commitStackView.spacing = 1
      commitStackView.layer.cornerRadius = 8
      commitStackView.layer.masksToBounds = true
      // Subviews
      contentView.addSubview(commitStackView)
      // Constraints
      commitStackView.setupEdgeConstraints(top: contentView.safeAreaLayoutGuide.topAnchor,
                                           trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                                           bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                                           leading: contentView.safeAreaLayoutGuide.leadingAnchor)
   }
}
