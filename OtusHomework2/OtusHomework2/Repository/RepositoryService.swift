//
//  CoreDataRepository.swift
//  OtusHomework2
//
//  Created by Daria.S on 22.01.2022.
//

import CoreData

protocol RepositoryServiceProtocol {
    func getAllNews() -> [ArticleEntity]
    func saveArticle(article: ArticleEntity)
}

class RepositoryService: RepositoryServiceProtocol {
    
    private var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArticleDB")
        container.loadPersistentStores { desc, error in
            if error != nil {
                fatalError()
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext? = nil
    
    init() {
        context = container.viewContext
    }
    
    func getAllNews() -> [ArticleEntity] {
        let request = ArticleDB.fetchRequest()
        var mappedArticles = [ArticleEntity]()
        
        do {
            let articles = try context?.fetch(request) ?? []
            mappedArticles = articles.map({ article in
                ArticleEntity(author: article.author,
                              title: article.title,
                              text: article.text,
                              url: article.url ?? "",
                              urlToImage: article.urlToImage,
                              publishedAt: article.publishedAt,
                              content: article.content)
            })
        } catch {
            print("Fetch error")
        }
        return mappedArticles
    }
    
    func saveArticle(article: ArticleEntity) {
        guard let context = context, getArticle(with: article.url) == nil else { return }
        
        let dbArticle = ArticleDB(context: context)
        dbArticle.title = article.title
        dbArticle.text = article.text
        dbArticle.author = article.author
        dbArticle.content = article.content
        dbArticle.publishedAt = article.publishedAt
        dbArticle.urlToImage = article.urlToImage
        dbArticle.url = article.url
        saveContext()
    }
    
    private func getArticle(with url: String) -> ArticleDB? {
        let request = ArticleDB.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        do {
            let results = try context?.fetch(request)
            return results?.first
        } catch {
            print("Fetch error")
            return nil
        }
    }
    
    private func saveContext() {
        if context?.hasChanges ?? false {
            do {
                try context?.save()
            } catch {
                print("save context error")
            }
        }
    }
}
