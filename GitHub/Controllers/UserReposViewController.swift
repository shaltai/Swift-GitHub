import UIKit

class UserReposViewController: ViewController {
   @IBOutlet var resultsTableView: UITableView!
   
   var selectedScopeButtonIndex: Int = 0
   private var models: [Codable] = []
   private var user: String = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   func initUserRepos(repos: [Repos.Items], user: String) {
      self.models = repos
      self.title = "\(user) repositories"
      self.user = user
   }
   
   func initReposDetails(details: RepoDetails, user: String, repo: String) {
      self.models = [details]
      self.title = "\(user) \\ \(repo)"
   }
   
   func initCommitDetails(details: CommitDetails, message: String) {
      self.models = [details]
      self.title = "\(message)"
   }
   
   override func setupSearchController() {
      searchController.delegate = self
      searchController.searchBar.delegate = self
      searchController.searchResultsUpdater = self
      searchController.searchBar.placeholder = "Search for Code"
      searchController.definesPresentationContext = true
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
   }
   
   override func setup() {
      resultsTableView.backgroundColor = .systemBackground
      resultsTableView.allowsSelection = false
      resultsTableView.separatorStyle = .none
      resultsTableView.rowHeight = UITableView.automaticDimension
      resultsTableView.estimatedRowHeight = 200
      resultsTableView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
   }
}

// Table
extension UserReposViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch selectedScopeButtonIndex {
         
      // Search for users
      case 0:
         if searchController.searchBar.text != "" {
            
            // Cell with code samples
            let cell = tableView.dequeueReusableCell(withIdentifier: "CodeTableViewCell",
                                                     for: indexPath) as! CodeTableViewCell
            cell.initCell(code: models[indexPath.row] as! Code.Items)
            return cell
            
         } else {
            
            // Cell with user repositories
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell",
                                                     for: indexPath) as! RepoTableViewCell
            cell.initCell(repo: models[indexPath.row] as! Repos.Items)
            return cell
            
         }
         
      // Search for repositories
      case 1:
         // Hide searchbar
         self.searchController.isActive = false
         self.navigationItem.searchController = nil
         // Cell with repositoru details
         let cell = tableView.dequeueReusableCell(withIdentifier: "RepoDetailsTableViewCell",
                                                  for: indexPath) as! RepoDetailsTableViewCell
         cell.initCell(details: models[indexPath.row] as! RepoDetails)
         return cell
         
      // Search for commits
      case 2:
         // Hide searchbar
         self.searchController.isActive = false
         self.navigationItem.searchController = nil
         // Cell with commit details
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommitDetailsTableViewCell",
                                                  for: indexPath) as! CommitDetailsTableViewCell
         cell.initCell(details: models[indexPath.row] as! CommitDetails)
         return cell
         
      default:
         let cell = UITableViewCell()
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
