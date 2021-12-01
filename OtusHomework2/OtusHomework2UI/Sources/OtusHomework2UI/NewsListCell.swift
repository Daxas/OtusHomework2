//
//  NewsListCell.swift
//
//  Created by Daria.S on 06.11.2021.
//

import SwiftUI

public struct NewsListCell: View {
    
    public init(newsTitle: String?, isPageLoading: Bool) {
        self.newsTitle = newsTitle ?? "NO TITLE"
        self.isPageLoading = isPageLoading
    }
    
    let newsTitle: String
    let isPageLoading: Bool
    
    public var body: some View {
        buttonContent
    }
    
    var buttonContent: some View {
        VStack {
            Text(newsTitle)
                .padding()
            if isPageLoading {
                VStack(alignment: .center) {
                    Divider()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
    }
}
