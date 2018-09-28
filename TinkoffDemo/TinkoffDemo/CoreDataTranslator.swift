//
//  CoreDataTranslator.swift
//  TinkoffDemo
//
//  Created by Andrey Morozov on 24.09.2018.
//  Copyright © 2018 Jastic7. All rights reserved.
//

import Foundation
import CoreData

class CoreDataTranslator {
	
	func fill(entry: MONews, from entity: News, in context: NSManagedObjectContext) {
		if entry.header == nil {
			entry.header = MONewsHeader(context: context)
		}
		fill(entry: entry.header!, from: entity.header)
		
		if let details = entity.details {
			if entry.details == nil {
				entry.details = MONewsDetails(context: context)
			}
			fill(entry: entry.details!, from: details)
		}
	}
	
	func createEntity(from entry: MONews) -> News {
		let header = createEntity(from: entry.header!)
		let details = createEntity(from: entry.details)
		
		return News(header: header, details: details, views: UInt(entry.views))
	}
	
	
	// MARK:- Private
	
	private func fill(entry: MONewsHeader, from entity: NewsHeader) {
		entry.id = entity.id
		entry.publicationDate = entity.publicationDate as NSDate
		entry.text = entity.text
	}
	
	private func fill(entry: MONewsDetails, from entity: NewsDetails) {
		entry.content = entity.content
		entry.creationDate = entity.creationDate as NSDate
		entry.lastModificationDate = entity.lastModificationDate as NSDate
	}
	
	private func createEntity(from entry: MONewsHeader) -> NewsHeader {
		return NewsHeader(id: entry.id, text: entry.text, publicationDate: entry.publicationDate as Date)
	}
	
	private func createEntity(from entry: MONewsDetails?) -> NewsDetails? {
		guard let moDetails = entry else { return nil }
		return NewsDetails(content: moDetails.content,
						   creationDate: moDetails.creationDate as Date,
						   lastModificationDate: moDetails.lastModificationDate as Date)
	}
}
