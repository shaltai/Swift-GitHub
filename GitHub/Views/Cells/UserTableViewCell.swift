import UIKit

class UserTableViewCell: UITableViewCell {
   let loginLabel = UILabel()
   let idLabel = UILabel()
   let avatarImage = UIImageView()
   
   override func awakeFromNib() {
      super.awakeFromNib()

      setup()
   }
   
   func initCell(user: Users.Items) {
      loginLabel.text = user.login
      idLabel.text = "\(user.id)"
      guard let avatarUrl = URL(string: user.avatar_url) else { return }
      if let imageData = try? Data(contentsOf: avatarUrl) {
         avatarImage.image = UIImage(data: imageData)
      }
   }
   
   func setup() {
      // settings
      backgroundColor = .systemGray6
      // subviews
      addSubview(avatarImage)
      addSubview(loginLabel)
      addSubview(idLabel)
      // constraints
      avatarImage.setupEdgeConstraints(top: topAnchor,
                                       leading: leadingAnchor,
                                       size: CGSize(width: 128.0, height: 128.0)
      )
      loginLabel.setupEdgeConstraints(top: topAnchor,
                                      trailing: trailingAnchor,
                                      leading: avatarImage.trailingAnchor,
                                      padding: UIEdgeInsets(top: 32, left: 8, bottom: 16, right: 8))
      idLabel.setupEdgeConstraints(top: loginLabel.bottomAnchor,
                                   trailing: trailingAnchor,
                                   leading: avatarImage.trailingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 8, bottom: 24, right: 8))
   }
}
