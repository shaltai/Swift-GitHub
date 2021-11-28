import UIKit

class ViewController: UIViewController {
   private var models: [Codable] = []
   private var path = Path.users
   
   @IBOutlet weak var searchTextField: UITextField!
   @IBOutlet weak var searchResultsTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
      
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? UserReposViewController,
         segue.identifier == "ShowUserRepos" {
         
         // Index
         guard let indexPath = searchResultsTableView.indexPathForSelectedRow else { return }
         
         // User name at particular index
         let userItem = models[indexPath.row] as! Users.Items
         let user = userItem.login
         
         Network.shared.fetchData(path: "/users", query: "/\(user)/repos", type: [Repos.Items].self) { repos in

            vc.initUserRepos(repos: repos, user: user)
            vc.userReposTableView.reloadData()
         }
         // Deselect row
         searchResultsTableView.deselectRow(at: indexPath, animated: true)
      }
   }
   
   func setup() {
      title = "Search in GitHub"
      searchResultsTableView.backgroundColor = .systemBackground
   }
   
   @IBAction func searchButton(_ sender: UIButton) {
      guard let text = searchTextField.text else { return }
      
      if text.isEmpty {
         
         // Reset table
         models = []
         searchResultsTableView.reloadData()
         
      } else {
         let query = "?q=\(text)"
         
         // Request
         switch path {
         case .users:
            Network.shared.fetchData(path: path.rawValue, query: query, type: Users.self) { users in
               self.models = users.items
               self.searchResultsTableView.reloadData()
            }
         case .repositories:
            Network.shared.fetchData(path: path.rawValue, query: query, type: Repos.self) { repos in
               self.models = repos.items
               self.searchResultsTableView.reloadData()
            }
         case .commits:
            Network.shared.fetchData(path: path.rawValue, query: query, type: Commits.self) { commits in
               self.models = commits.items
               self.searchResultsTableView.reloadData()
            }
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
         cell.initCell(user: models[indexPath.row] as! Users.Items)
         return cell
         
      case .repositories:
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
         cell.initCell(repo: models[indexPath.row] as! Repos.Items)
         return cell
         
      default:
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as! CommitTableViewCell
         cell.initCell(commit: models[indexPath.row] as! Commits.Items)
         return cell
      }
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "ShowUserRepos", sender: indexPath)
   }
   
   
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 128
   }
}

