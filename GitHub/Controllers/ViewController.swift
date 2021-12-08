import UIKit

class ViewController: UIViewController {
   let searchController = UISearchController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
      setupSearchController()
      
   }
   
   func setup() {
      title = "Search in GitHub"
   }
   
   // Search
   func setupSearchController() {
      
   }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      return cell
   }
}

extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      
   }
   
   func updateSearchResults(for searchController: UISearchController) {
      
   }
}

