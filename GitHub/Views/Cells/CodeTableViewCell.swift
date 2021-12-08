import UIKit

class CodeTableViewCell: UITableViewCell {
   let codeTableView = UITableView()
   var codeTextMatches: [Code.Items.TextMatches] = []
   
   override func awakeFromNib() {
      super.awakeFromNib()

      setup()
   }
   
   func initCell(code: Code.Items) {
      self.codeTextMatches = code.text_matches
   }
   
   func setup() {
      // table settings
      codeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      codeTableView.delegate = self
      codeTableView.dataSource = self
      codeTableView.layer.cornerRadius = 8
      codeTableView.estimatedRowHeight = 80
      codeTableView.rowHeight = UITableView.automaticDimension
      // subviews
      addSubview(codeTableView)
      // constraints
      codeTableView.setupEdgeConstraints(top: topAnchor,
                                         trailing: trailingAnchor,
                                         bottom: bottomAnchor,
                                         leading: leadingAnchor)
   }
}

extension CodeTableViewCell: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      codeTextMatches.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      var content = cell.defaultContentConfiguration()
      content.text = codeTextMatches[indexPath.row].fragment
      content.textProperties.numberOfLines = 0
      content.textProperties.lineBreakMode = .byCharWrapping
      cell.contentConfiguration = content

      return cell
   }
   
}
