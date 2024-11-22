import SwiftUI

struct ContentView: View {
    // Створюємо екземпляр NewsService, щоб отримувати дані
    @StateObject private var newsService = NewsService()
    
    var body: some View {
        NavigationView {
            List(newsService.articles) { article in
                VStack(alignment: .leading) {
                    // Fix the typo URl -> URL
                    if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipped()
                    }
                    
                    // Fixed typo `titile` -> `title`
                    Text(article.title)
                        .font(.headline)
                    
                    // Corrected handling of optional description
                    Text(article.description ?? "No description")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Latest news")
            .onAppear {
                newsService.fetchNews()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())  // Для кращої підтримки iPad та iPhone
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {    
        ContentView()
    }
}
