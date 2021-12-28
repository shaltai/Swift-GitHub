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
      let name: String
      let full_name: String
      let description: String?
      let language: String?
      let stargazers_count: Int
      let updated_at: String
      var updatedAt: Date {
         toDate(from: updated_at)
      }
      // Owner
      struct Owner: Codable {
         let login: String
      }
      let owner: Owner
   }
   let items: [Items]
}

struct RepoDetails: Codable {
   let download_url: String
}

struct Commits: Codable {
   struct Items: Codable {
      let sha: String
      // Commit
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
      // Repository
      struct Repository: Codable {
         let full_name: String
         let name: String
         // Owner
         struct Owner: Codable {
            let login: String
         }
         let owner: Owner
      }
      let repository: Repository
   }
   let items: [Items]
}

struct CommitDetails: Codable {
   // Files
   struct Files: Codable {
      let filename: String
      let patch: String?
   }
   let files: [Files]
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
      let text_matches: [TextMatches]
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
