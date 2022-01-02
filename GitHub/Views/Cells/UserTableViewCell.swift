import UIKit

class UserTableViewCell: UITableViewCell {
   let view = UIView()
   let loginLabel = UILabel()
   let idLabel = UILabel()
   let avatarImage = UIImageView()
   
   override func awakeFromNib() {
      super.awakeFromNib()

   }
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(user: Users.Items) {
      loginLabel.attributedText = NSMutableAttributedString(string: user.login).setupAttributes(style: .heading(level: .h3),
                                                                                                align: .left,
                                                                                                color: .black)
      idLabel.attributedText = NSMutableAttributedString(string: "\(user.id)").setupAttributes(style: .paragraph(level: .p2),
                                                                                               align: .left,
                                                                                               color: .systemGray)
      guard let avatarUrl = URL(string: user.avatar_url) else { return }
      if let imageData = try? Data(contentsOf: avatarUrl) {
         avatarImage.image = UIImage(data: imageData)
      }
   }
   
   func setup() {
      // Settings
      avatarImage.layer.cornerRadius = 8
      avatarImage.contentMode = .scaleAspectFit
      avatarImage.clipsToBounds = true
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      // Subviews
      contentView.addSubview(avatarImage)
      contentView.addSubview(view)
      view.addSubview(loginLabel)
      view.addSubview(idLabel)
      // Constraints
      view.setupEdgeConstraints(top: contentView.topAnchor,
                                trailing: contentView.trailingAnchor,
                                bottom: contentView.bottomAnchor,
                                leading: avatarImage.trailingAnchor)
      
      loginLabel.setupEdgeConstraints(top: view.topAnchor,
                                      trailing: view.trailingAnchor,
                                      bottom: idLabel.topAnchor,
                                      leading: view.leadingAnchor,
                                      padding: UIEdgeInsets(top: 40, left: 8, bottom: 12, right: 8))
      loginLabel.setContentHuggingPriority(UILayoutPriority(760), for: .vertical)
      loginLabel.setContentCompressionResistancePriority(UILayoutPriority(769), for: .vertical)
      
      idLabel.setupEdgeConstraints(trailing: view.trailingAnchor,
                                   bottom: view.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 8, bottom: 40, right: 8))
      idLabel.setContentHuggingPriority(UILayoutPriority(770), for: .vertical)
      
      avatarImage.setupEdgeConstraints(leading: contentView.leadingAnchor)
      avatarImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
      avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor).isActive = true
      avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      setup()
   }
}
