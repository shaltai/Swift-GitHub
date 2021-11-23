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
         let query = "?q=\(query)"
         guard let url = URL(string: api + path + query) else { return }
         print(url)
         URLSession.shared.dataTask(with: url) { data, response, error in
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
