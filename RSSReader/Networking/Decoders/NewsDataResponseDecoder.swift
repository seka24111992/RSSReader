//
//  NewsDataResponseDecoder.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyXMLParser

open class NewsDataResponseDecoder: ResponseDecoder<[News]> {

    public final override func decode(response: HTTPURLResponse, data: Data?) throws -> [News] {

        var newsArray = [News]()

        if let data = data {

            let xml = XML.parse(data)
            guard
                let source = xml.rss.channel.title.text
            else
            {
                throw APIError.invalidDecoder
            }

            for item in xml["rss", "channel", "item"] {
                let title = item["title"].text
                let description = item["description"].text
                let thubnailPath = item["enclosure"].attributes["url"]
                let pubDate = item["pubDate"].text
                let link = item["link"].text

                
                let news = News()
                news.uuid = UUID()
                news.title = title?.withoutHTML()
                news.source = source
                news.newsDescription = description
                news.externalThubnailPath = thubnailPath
                news.createDate = Date.fromString(string: pubDate ?? "") ?? Date()
                news.link = link
                
                newsArray.append(news)
                
            }
        } else {
            throw APIError.noDataInResponse
        }
        
        return newsArray
    }
}
