//
//  ArticleDetailScreen.swift
//  OtusHomework2
//
//  Created by Daria.S on 03.11.2021.
//

import SwiftUI
import Networking
import OtusHomework2UI
import SDWebImageSwiftUI

struct ArticleDetailScreen: View {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                HStack(alignment: .center) {
                    NavPopButton(destination: .root) {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Text("Details")
                        .font(.title)
                    
                    Spacer()
                    
                    NavPushButton(destination: ArticleInfoScreen(article: self.article)) {
                        Image(systemName: "info.circle")
                            .font(.title)
                    }
                }
                
                Text(article.title ?? "NO TITLE")
                    .font(.largeTitle)
                    .fixedSize(horizontal: false, vertical: true)
                
                WebImage(url: URL(string: article.urlToImage ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                if let description = article.description {
                    Text(description)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 20)
        }
    }
}
