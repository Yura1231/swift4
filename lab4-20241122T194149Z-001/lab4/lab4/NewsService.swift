import Foundation

class NewsService: ObservableObject {
    @Published var articles: [Article] = []
    
    private let apiKey = "0f572bce5b754aa3a3fea2b9cb12e2f8"
    
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
