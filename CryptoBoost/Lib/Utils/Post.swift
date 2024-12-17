//
//  Post.swift
//  CryptoBoost
//
//  Created by mac on 17/12/2024.
//

import Foundation

//JSON Structure

//{
//  "articles": {
//    "results": [
//      {
//        "url": "https://cryptonewsland.com/mt-gox-moves-170m-in-bitcoin-as-creditor-repayments/",
//        "title": "Mt.Gox Moves $170M in Bitcoin as Creditor Repayments Near Completion",
//        "body": "Analysts speculate Mt.Gox repayments may impact Bitcoin prices...",
//        "image": "https://cryptonewsland.com/wp-content/uploads/2024/07/btc-mt-gox.jpg"
//      }
//    ]
//  }
//}


struct Article: Codable, Identifiable {
    var id = UUID()
    let title: String
    let image: String
    let link: String
    
    // Custom mapping for the "url" field
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case link = "url" // Map "url" from JSON to "link" in your model
    }
}

struct ArticlesResponse: Codable {
    let articles: ArticlesResults
    
    struct ArticlesResults: Codable {
        let results: [Article]
    }
}

@Observable
class NewsView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var articles: [Article] = []
    var loadingState: LoadingState = .loading
    var errorMessage: String?
    
    func fetchNews() async {
        loadingState = .loading
        errorMessage = nil
        
        let urlString = "https://eventregistry.org/api/v1/article/getArticles?resultType=articles&keyword=Bitcoin&keyword=Ethereum&keyword=Litecoin&keywordOper=or&lang=eng&articlesSortBy=date&includeArticleConcepts=true&includeArticleCategories=true&articleBodyLen=300&articlesCount=10&apiKey=45579897-104d-4d14-987a-ea9427fb31c4"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            loadingState = .failed
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode JSON response
            let decodedResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
            
            // Access "results" nested inside "articles"
            self.articles = decodedResponse.articles.results
            loadingState = .loaded
        } catch {
            errorMessage = "Failed to load articles: \(error.localizedDescription)"
            loadingState = .failed
        }
    }
}


