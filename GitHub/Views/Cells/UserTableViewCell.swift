import UIKit

class UserTableViewCell: UITableViewCell {
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
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
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
      avatarImage.layer.cornerRadius = 8
      avatarImage.contentMode = .scaleAspectFit
      avatarImage.clipsToBounds = true
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      for label in [loginLabel, idLabel] {
         label.numberOfLines = 0
         label.lineBreakMode = .byCharWrapping
      }
      // subviews
      contentView.addSubview(avatarImage)
      contentView.addSubview(loginLabel)
      contentView.addSubview(idLabel)
      // constraints
      avatarImage.setupEdgeConstraints(top: contentView.topAnchor,
                                       leading: contentView.leadingAnchor,
                                       size: CGSize(width: 128, height: 128))
      
      loginLabel.setupEdgeConstraints(top: contentView.topAnchor,
                                      trailing: contentView.trailingAnchor,
                                      bottom: idLabel.topAnchor,
                                      leading: avatarImage.trailingAnchor,
                                      padding: UIEdgeInsets(top: 40, left: 8, bottom: 16, right: 8))
      
      idLabel.setupEdgeConstraints(trailing: contentView.trailingAnchor,
                                   bottom: contentView.bottomAnchor,
                                   leading: avatarImage.trailingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 8, bottom: 40, right: 8))
   }
}
