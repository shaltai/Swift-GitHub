import UIKit

class MainViewController: ViewController {
   private var models: [Codable] = []
   private var path: Path = Path.users
   
   @IBOutlet weak var searchResultsTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   // Segue on cell click
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? UserReposViewController {
         switch segue.identifier {
            
         case "ShowUserRepos":
            // Index
            guard let indexPath = searchResultsTableView.indexPathForSelectedRow else { return }
            // User name at particular index
            let userItem = models[indexPath.row] as! Users.Items
            let user = userItem.login
            // Request and init user repos
            Network.shared.fetchData(path: "/users",
                                     query: "/\(user)/repos",
                                     type: [Repos.Items].self) { repos in
               vc.initUserRepos(repos: repos, user: user)
               vc.selectedScopeButtonIndex = 0
               vc.resultsTableView.reloadData()
            }
            // Deselect row
            searchResultsTableView.deselectRow(at: indexPath, animated: true)
            
         case "ShowRepoDetail":
            // Index
            guard let indexPath = searchResultsTableView.indexPathForSelectedRow else { return }
            // User name at particular index
            let reposItem = models[indexPath.row] as! Repos.Items
            let user = reposItem.owner.login
            let repo = reposItem.name
            // Request and init repo details
            Network.shared.fetchData(path: "/repos",
                                     query: "/\(user)/\(repo)/readme",
                                     type: RepoDetails.self) { repoDetails in
               vc.selectedScopeButtonIndex = 1
               vc.initReposDetails(details: repoDetails, user: user, repo: repo)
               vc.resultsTableView.reloadData()
            }
            // Deselect row
            searchResultsTableView.deselectRow(at: indexPath, animated: true)
         
         case "ShowCommitFiles":
            // Index
            guard let indexPath = searchResultsTableView.indexPathForSelectedRow else { return }
            // User name at particular index
            let commitItem = models[indexPath.row] as! Commits.Items
            let user = commitItem.repository.owner.login
            let repo = commitItem.repository.name
            let sha = commitItem.sha
            let message = commitItem.commit.message
            // Request and init commit details
            Network.shared.fetchData(path: "/repos",
                                     query: "/\(user)/\(repo)/commits/\(sha)",
                                     type: CommitDetails.self) { commitDetails in
               vc.initCommitDetails(details: commitDetails, message: message)
               vc.selectedScopeButtonIndex = 2
               vc.resultsTableView.reloadData()
            }
            // Deselect row
            searchResultsTableView.deselectRow(at: indexPath, animated: true)
            
         default:
            break
         }
      }
   }
   
   override func setup() {
      title = "Search in GitHub"
      searchResultsTableView.separatorStyle = .none
      searchResultsTableView.backgroundColor = .systemBackground
      searchResultsTableView.rowHeight = UITableView.automaticDimension
      searchResultsTableView.estimatedRowHeight = 200
   }
   
   // Setup search
   override func setupSearchController() {
      navigationItem.searchController = searchController
      searchController.delegate = self
      searchController.searchBar.delegate = self
      searchController.searchResultsUpdater = self
      searchController.definesPresentationContext = true
      searchController.searchBar.placeholder = "Search for Users"
      searchController.searchBar.scopeButtonTitles = ["Users", "Repos", "Commits"]
      searchController.automaticallyShowsScopeBar = false
      searchController.searchBar.showsScopeBar = true
   }
}

// Table
extension MainViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      switch path {
      case .users:
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
         cell.initCell(user: models[indexPath.row] as! Users.Items)
         return cell
         
      case .repositories:
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
         cell.initCell(repo: models[indexPath.row] as! Repos.Items)
         return cell
         
      case .commits:
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommitTableViewCell", for: indexPath) as! CommitTableViewCell
         cell.initCell(commit: models[indexPath.row] as! Commits.Items)
         return cell
         
      default:
         let cell = UITableViewCell()
         return cell
      }
   }
}

// Search
extension MainViewController {
   
   override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      guard let text = searchController.searchBar.text else { return }
      let query = "?q=\(text)"
      
      // Request
      switch path {
      case .users:
         Network.shared.fetchData(path: path.rawValue, query: query, type: Users.self) { [weak self] users in
            if let self = self {
               self.models = users.items
               self.searchResultsTableView.reloadData()
            }
         }
      case .repositories:
         Network.shared.fetchData(path: path.rawValue, query: query, type: Repos.self) { [weak self] repos in
            if let self = self {
               self.models = repos.items
               self.searchResultsTableView.reloadData()
            }
         }
      case .commits:
         Network.shared.fetchData(path: path.rawValue, query: query, type: Commits.self) { [weak self] commits in
            if let self = self {
               self.models = commits.items
               self.searchResultsTableView.reloadData()
            }
         }
      default:
         break
      }
   }
   
   override func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else { return }
      
      if text.isEmpty {
         // Reset table
         models = []
         searchResultsTableView.reloadData()
      }
   }
   
   // Scope buttons
   func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
      // Search query
      guard let text = searchController.searchBar.text else { return }
      let query = "?q=\(text)"
      // Search scope selecting logic
      switch searchBar.selectedScopeButtonIndex {
      // Search for users
      case 0:
         // Placeholder
         searchController.searchBar.placeholder = "Search for Users"
         // Change path value
         path = .users
         // Request and populate models array
         if !text.isEmpty {
            Network.shared.fetchData(path: path.rawValue, query: query, type: Users.self) { [weak self] users in
               if let self = self {
                  self.models = users.items
                  DispatchQueue.main.async {
                     self.searchResultsTableView.reloadData()
                  }
               }
            }
         }
      // Search for repositories
      case 1:
         // Placeholder
         searchController.searchBar.placeholder = "Search for Repositories"
         // Change path value
         path = .repositories
         // Request and populate models array
         if !text.isEmpty {
            Network.shared.fetchData(path: path.rawValue, query: query, type: Repos.self) { [weak self] repos in
               if let self = self {
                  self.models = repos.items
                  DispatchQueue.main.async {
                     self.searchResultsTableView.reloadData()
                  }
               }
            }
         }
      // Search for commits
      case 2:
         // Placeholder
         searchController.searchBar.placeholder = "Search for Commits"
         // Change path value
         path = .commits
         // Request and populate models array
         if !text.isEmpty {
            Network.shared.fetchData(path: path.rawValue, query: query, type: Commits.self) { [weak self] commits in
               if let self = self {
                  self.models = commits.items
                  DispatchQueue.main.async {
                     self.searchResultsTableView.reloadData()
                  }
               }
            }
         }
      default:
         break
      }
   }
}

