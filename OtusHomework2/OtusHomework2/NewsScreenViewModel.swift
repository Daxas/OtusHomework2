//
//  NewsScreenViewModel.swift
//  OtusHomework2
//
//  Created by Daria.S on 04.11.2021.
//

import SwiftUI
import Networking

final class NewsScreenViewModel: ObservableObject {
    
    @Published var newsList: [Article] = .init()
    
    @Published var page: Int = 0
    @Published var isPageLoading: Bool = false
    
    @Published var totalResults: Int = Int.max
    
    init(topic: String, startDate: String) {
        self.topic = topic
        self.startDate = startDate
        loadPage()
    }
    
    private let topic: String
    private let startDate: String
    
    func loadPage() {
        guard isPageLoading == false, newsList.count < totalResults else { return }
        
        isPageLoading = true
        page += 1
        ArticlesAPI.everythingGet(q: self.topic,
                                  from: self.startDate,
                                  sortBy: "publishedAt",
                                  language: "ru",
                                  apiKey: "a59e5f24831a4322b535578654582973",
                                  page: page) { list, error in
            self.newsList.append(contentsOf: list?.articles ?? [])
            if let totalResults = list?.totalResults {
                self.totalResults = totalResults
            }
            self.isPageLoading = false
        }
    }
    
    
}
