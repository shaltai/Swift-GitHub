import UIKit

class CodeTableViewCell: UITableViewCell {
   let codeStackView = UIStackView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(code: Code.Items) {
      for view in codeStackView.subviews {
         view.removeFromSuperview()
      }
      
      for match in 0...code.text_matches.count - 1 {
         // wrapper view
         let view = UIView()
         view.backgroundColor = match % 2 == 0 ? .systemGray6 : .systemGray4
         // label settings
         let codeLabel = UILabel()
         codeLabel.numberOfLines = 0
         codeLabel.text = code.text_matches[match].fragment
         // subviews
         view.addSubview(codeLabel)
         codeStackView.addArrangedSubview(view)
         // constraints
         codeLabel.setupEdgeConstraints(top: view.topAnchor,
                                        trailing: view.trailingAnchor,
                                        bottom: view.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
      }
   }
   
   func setup() {
      // Stack settings
      codeStackView.axis = .vertical
      codeStackView.distribution = .equalSpacing
      codeStackView.spacing = 1
      codeStackView.layer.cornerRadius = 8
      codeStackView.layer.masksToBounds = true
      // Subviews
      contentView.addSubview(codeStackView)
      // Constraints
      codeStackView.setupEdgeConstraints(top: contentView.safeAreaLayoutGuide.topAnchor,
                                         trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                                         bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                                         leading: contentView.safeAreaLayoutGuide.leadingAnchor)
   }
}

