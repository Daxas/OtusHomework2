//
//  ArticleInfoScreen.swift
//  OtusHomework2
//
//  Created by Daria.S on 06.11.2021.
//

import SwiftUI
import Networking
import OtusHomework2UI

struct ArticleInfoScreen: View {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    NavPopButton(destination: .previous) {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Text("Info")
                        .font(.title)
                    
                    Spacer()
                    
                    NavPopButton(destination: .root) {
                        Image(systemName: "list.bullet.circle")
                            .font(.title)
                    }
                }
                
                Spacer(minLength: 40)
                
                Text("Author: ")
                    .font(.title)
                    .bold()
                
                Text(article.author ?? "Unknown")
                    .font(.title)
                
                Spacer(minLength: 40)
                
                Text("PublishedAt: ")
                    .font(.title)
                    .bold()
                
                Text(formate(date: article.publishedAt))
                    .font(.title)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 20)
        }
    }
    
    private func formate(date: Date?) -> String {
        let formatter = DateFormatter()
        guard let date = date else {
            return "Unknown"
        }
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
