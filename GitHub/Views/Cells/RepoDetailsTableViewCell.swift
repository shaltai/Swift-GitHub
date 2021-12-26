import UIKit

class RepoDetailsTableViewCell: UITableViewCell {
   let readmeTextView = UITextView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()

   }
   
   func initCell(details: RepoDetails) {
      do {
         guard let fileURL = URL(string: details.download_url) else { return }
         let detailsContent = try String(contentsOf: fileURL, encoding: .utf8)
         readmeTextView.attributedText = try? NSAttributedString(markdown: detailsContent)
      } catch {
         print("Error is: \(error)")
      }
      
   }
         
   
   func setup() {
      readmeTextView.allowsEditingTextAttributes = false
      readmeTextView.isScrollEnabled = false
      contentView.addSubview(readmeTextView)
      readmeTextView.setupEdgeConstraints(top: contentView.topAnchor,
                                          trailing: contentView.trailingAnchor,
                                          bottom: contentView.bottomAnchor,
                                          leading: contentView.leadingAnchor)
   }
}
