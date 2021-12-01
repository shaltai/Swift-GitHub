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
      let description: String?
      let language: String?
      let stargazers_count: Int
      let updated_at: String
      var updatedAt: Date {
         toDate(from: updated_at)
      }
   }
   let items: [Items]
}

struct Commits: Codable {
   struct Items: Codable {
      let sha: String
      struct Commit: Codable {
         struct Committer: Codable {
            let name: String
            let date: String
            var commitDate: Date {
               toDate(from: date)
            }
         }
         let committer: Committer
         let message: String
      }
      let commit: Commit
      struct Repository: Codable {
         let full_name: String
      }
      let repository: Repository
   }
   let items: [Items]
}

struct Code: Codable {
   struct Items: Codable {
      struct TextMatches: Codable {
         let fragment: String
         struct Matches: Codable {
            let text: String
            let indices: [Int]
         }
         let matches: [Matches]
      }
      let text_matches: TextMatches
   }
   let items: [Items]
}

extension Decodable {
   // Convert string date from JSON to Date
   func toDate(from string: String) -> Date {
      let formatter = DateFormatter()
      guard let date = formatter.date(from: string) else { return Date() }
      return date
   }
}
