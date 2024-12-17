//
//  HomeScreen.swift
//  CryptoBoost
//
//  Created by mac on 17/12/2024.
//

import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = NewsView()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView("Loading...")
                case .loaded:
                    List(viewModel.articles) { article in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(article.title)
                                .font(.headline)
                            AsyncImage(url: URL(string: article.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                            } placeholder: {
                                Color.gray
                                    .frame(height: 150)
                            }
                            Link("Read More", destination: URL(string: article.link)!)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 8)
                    }
                case .failed:
                    VStack {
                        Text("Error: \(viewModel.errorMessage ?? "Unknown error")")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchNews()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Crypto News")
            .task {
                await viewModel.fetchNews()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
