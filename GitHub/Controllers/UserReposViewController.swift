import UIKit

class UserReposViewController: ViewController {
   @IBOutlet var resultsTableView: UITableView!
   
   private var models: [Codable] = []
   private var user: String = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   func initUserRepos (repos: [Repos.Items], user: String) {
      self.models = repos
      self.title = "\(user) repositories"
      self.user = user
   }
   
   override func setupSearchController() {
      searchController.delegate = self
      searchController.searchBar.delegate = self
      searchController.searchResultsUpdater = self
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
   }
   
   override func setup() {
      resultsTableView.backgroundColor = .systemBackground
      resultsTableView.separatorStyle = .none
      resultsTableView.rowHeight = UITableView.automaticDimension
      resultsTableView.estimatedRowHeight = 500
   }
}

// Table
extension UserReposViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if searchController.searchBar.text != "" {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "CodeTableViewCell", for: indexPath) as! CodeTableViewCell
         cell.initCell(code: models[indexPath.row] as! Code.Items)
         cell.sizeToFit()
         return cell
         
      } else {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
         cell.initCell(repo: models[indexPath.row] as! Repos.Items)
         return cell
         
      }
   }
}

// Search
extension UserReposViewController {
   override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      guard let text = searchController.searchBar.text else { return }
      
      let query = "?q=\(text)+user:\(user)"
      
      Network.shared.fetchData(path: Path.code.rawValue, query: query, type: Code.self) { [weak self] code in
         if let self = self {
            self.models = code.items
            self.resultsTableView.reloadData()
         }
      }
   }
   
   override func updateSearchResults(for searchController: UISearchController) {
      
   }
   
}
