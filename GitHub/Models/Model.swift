import Foundation

struct Users: Codable {
   struct Items: Codable {
      let login: String
      let id: Int
      let avatar_url: String
   }
   let items: [Items]
}

struct Repos: Codable {
   struct Items: Codable {
      let full_name: String
      let description: String
      let language: String
      let stargazers_count: Int
      let updated_at: String
   }
   let items: [Items]
}
