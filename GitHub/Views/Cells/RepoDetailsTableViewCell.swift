import UIKit

class RepoDetailsTableViewCell: UITableViewCell {
   let readmeTextView = UITextView()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setup()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
   }
   
   func initCell(details: RepoDetails) {
      do {
         guard let fileURL = URL(string: details.download_url) else { return }
         let detailsContent = try String(contentsOf: fileURL, encoding: .utf8)
         var markdownOptions = AttributedString.MarkdownParsingOptions()
         markdownOptions.allowsExtendedAttributes = true
         markdownOptions.interpretedSyntax = .inlineOnlyPreservingWhitespace
         readmeTextView.attributedText = try? NSAttributedString(markdown: detailsContent, options: markdownOptions)
      } catch {
         print("Error is: \(error)")
      }
   }
         
   func setup() {
      readmeTextView.allowsEditingTextAttributes = false
      readmeTextView.isScrollEnabled = false
      readmeTextView.backgroundColor = .clear
      contentView.backgroundColor = .systemGray6
      contentView.layer.cornerRadius = 8
      contentView.addSubview(readmeTextView)
      readmeTextView.setupEdgeConstraints(top: contentView.topAnchor,
                                          trailing: contentView.trailingAnchor,
                                          bottom: contentView.bottomAnchor,
                                          leading: contentView.leadingAnchor,
                                          padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
   }
}
