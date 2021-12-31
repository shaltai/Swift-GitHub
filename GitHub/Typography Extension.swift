import UIKit

enum Heading {
   case h1, h2, h3
}

enum Paragraph {
   case p1, p2, p3
}

enum TextStyle {
   case heading(value: Heading)
   case paragraph(value: Paragraph)
}

// Constraints extension
extension NSAttributedString {
   func setupAttributes(style: TextStyle,
                        align: NSTextAlignment,
                        color: UIColor) -> NSAttributedString {
      
      let attributedString = NSMutableAttributedString(attributedString: self)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = align
      
      var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: style,
                                                       NSAttributedString.Key.foregroundColor: color]
      
      switch style {
      case .heading(let value):
         paragraphStyle.lineHeightMultiple = 1.1
         attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
         switch value {
         case .h1:
            attributes[NSAttributedString.Key.kern] = 0.7
         case .h2:
            attributes[NSAttributedString.Key.kern] = 0.5
         case .h3:
            attributes[NSAttributedString.Key.kern] = 0.3
         }
      case .paragraph:
         paragraphStyle.lineHeightMultiple = 1.4
         attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
      }
      
      attributedString.addAttributes(attributes, range: NSRange(location: 0, length: string.count))
      
      return NSAttributedString(attributedString: attributedString)
   }
}
