import Foundation

class Network {
   static let shared = Network()
   var model: Repos?
   
   func fetchData<T: Codable>(path: String,
                              query: String,
                              type: T.Type,
                              completionHandler: @escaping(T) -> Void) {
      
      if path.isEmpty == false,
         query.isEmpty == false {
         let api = "https://api.github.com"
         let query = query
         guard let url = URL(string: api + path + query) else { return }
         var request = URLRequest(url: url)
         request.setValue("token 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", forHTTPHeaderField: "Authorization")
         request.setValue("application/vnd.github.v3.text-match+json", forHTTPHeaderField: "Accept")

         URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let value = try JSONDecoder().decode(T.self, from: data)
                  DispatchQueue.main.async {
                     completionHandler(value)
                  }
               } catch {
                  print("Error is: \(error)")
               }
            }
         }.resume()
      }
   }
}

// https://api.github.com/search/code?q=somequery+language:swift
