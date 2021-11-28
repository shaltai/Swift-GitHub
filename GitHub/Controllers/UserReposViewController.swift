import UIKit

class UserReposViewController: UIViewController {
   @IBOutlet var userReposTableView: UITableView!
   
   private var models: [Repos.Items] = []
   private var user: String = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
   }
   
   func initUserRepos (repos: [Repos.Items], user: String) {
      self.models = repos
      self.title = "\(user) repositories"
   }
   
   func setup() {
      userReposTableView.backgroundColor = .systemBackground
   }
}

extension UserReposViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "UserReposCell", for: indexPath) as! RepoTableViewCell
      cell.initCell(repo: models[indexPath.row])
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      96
   }
}
