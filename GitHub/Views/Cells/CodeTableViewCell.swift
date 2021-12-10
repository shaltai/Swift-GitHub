import UIKit

class CodeTableViewCell: UITableViewCell {
   let codeStackView = UIStackView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   func initCell(code: Code.Items) {
      for view in codeStackView.subviews {
         view.removeFromSuperview()
      }
      
      for match in 0...code.text_matches.count - 1 {
         let codeLabel = UILabel()
         codeLabel.numberOfLines = 0
         codeLabel.text = code.text_matches[match].fragment
         codeLabel.backgroundColor = match % 2 == 0 ? .systemYellow : .systemGray6
         
         codeStackView.addArrangedSubview(codeLabel)
      }
   }
   
   func setup() {
      // stack settings
      codeStackView.axis = .vertical
      codeStackView.distribution = .equalSpacing
      // subviews
      addSubview(codeStackView)
      // constraints
      codeStackView.setupEdgeConstraints(top: topAnchor,
                                         trailing: trailingAnchor,
                                         bottom: bottomAnchor,
                                         leading: leadingAnchor,
                                         padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
   }
}

