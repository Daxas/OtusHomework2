//
//  ArticleDB+CoreDataProperties.swift
//  OtusHomework2
//
//  Created by allme on 22.01.2022.
//
//

import Foundation
import CoreData


extension ArticleDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleDB> {
        return NSFetchRequest<ArticleDB>(entityName: "ArticleDB")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?

}

extension ArticleDB : Identifiable {

}
