import UIKit

class ViewController: UIViewController {
   var models: [Codable] = []
   var path = Path.users
   
   
   @IBOutlet weak var searchTextField: UITextField!
   @IBOutlet weak var searchResultsTableView: UITableView!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
      
   }
   
   func setup() {
      searchResultsTableView.delegate = self
      searchResultsTableView.dataSource = self
      title = "Search in GitHub"
   }
   
   @IBAction func searchButton(_ sender: UIButton) {
      guard let text = searchTextField.text, text.isEmpty == false else { return }
      
      switch path {
      case .users:
         Network.shared.fetchData(path: path.rawValue, query: text, type: Users.self) { users in
            self.models = users.items
            self.searchResultsTableView.reloadData()
         }
      case .repositories:
         Network.shared.fetchData(path: path.rawValue, query: text, type: Repos.self) { repos in
            self.models = repos.items
            self.searchResultsTableView.reloadData()
         }
      case .commits:
         Network.shared.fetchData(path: path.rawValue, query: text, type: Commits.self) { commits in
            self.models = commits.items
            self.searchResultsTableView.reloadData()
         }
      }
   }
   
   @IBAction func searchSegmentedControl(_ sender: UISegmentedControl) {
      switch sender.selectedSegmentIndex {
      case 0:
         path = .users
      case 1:
         path = .repositories
      case 2:
         path = .commits
      default:
         break
      }
   }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      switch path {
      case .users:

         let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
         cell.initUserCell(user: models[indexPath.row] as! Users.Items)
         return cell

      case .repositories:

         let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
         cell.initUserCell(repo: models[indexPath.row] as! Repos.Items)
         return cell

      default:
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as! CommitTableViewCell
         cell.initUserCell(commit: models[indexPath.row] as! Commits.Items)
         return cell
      }
   }
   
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 128
   }
}

//      let secret = "f231a80c7b8df2b49b236dcfb007efef68c4f506"
//      let id = "dc9d3806ce3ddc2fd895"
