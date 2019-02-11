// To parse the JSON, add this file to your project and do:
//
//   let googleSearchJSON = try? newJSONDecoder().decode(GoogleSearchJSON.self, from: jsonData)

import Foundation

struct GoogleSearchJSON: Codable {
    let kind: String?
    let url: URLClass?
    let queries: Queries?
    let context: Context?
    let searchInformation: SearchInformation?
    let items: Array<Item>?
    let error : Error?
    
    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case url = "url"
        case queries = "queries"
        case context = "context"
        case searchInformation = "searchInformation"
        case items = "items"
        case error = "error"
    }
}

struct Context: Codable {
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}

struct Item: Codable {
    let kind: Kind?
    let title: String?
    let htmlTitle: String?
    let link: String?
    let displayLink: String?
    let snippet: String?
    let htmlSnippet: String?
    let cacheID: String?
    let formattedURL: String?
    let htmlFormattedURL: String?
    let pagemap: Pagemap?
    
    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case title = "title"
        case htmlTitle = "htmlTitle"
        case link = "link"
        case displayLink = "displayLink"
        case snippet = "snippet"
        case htmlSnippet = "htmlSnippet"
        case cacheID = "cacheId"
        case formattedURL = "formattedUrl"
        case htmlFormattedURL = "htmlFormattedUrl"
        case pagemap = "pagemap"
    }
}

enum Kind: String, Codable {
    case customsearchResult = "customsearch#result"
}

struct Pagemap: Codable {
    let cseThumbnail: [CSEThumbnail]?
    let metatags: [[String: String]]?
    let cseImage: [CSEImage]?
    let hcard: [Hcard]?
    let person: [Person]?
    let localbusiness: [Localbusiness]?
    let videoobject: [Videoobject]?
    let imageobject: [Imageobject]?
    
    enum CodingKeys: String, CodingKey {
        case cseThumbnail = "cse_thumbnail"
        case metatags = "metatags"
        case cseImage = "cse_image"
        case hcard = "hcard"
        case person = "person"
        case localbusiness = "localbusiness"
        case videoobject = "videoobject"
        case imageobject = "imageobject"
    }
}

struct CSEImage: Codable {
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case src = "src"
    }
}

struct CSEThumbnail: Codable {
    let width: String?
    let height: String?
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case width = "width"
        case height = "height"
        case src = "src"
    }
}

struct Hcard: Codable {
    let fn: String?
    let nickname: String?
    let photo: String?
    let logo: String?
    let category: String?
    let note: String?
    let pricerange: String?
    
    enum CodingKeys: String, CodingKey {
        case fn = "fn"
        case nickname = "nickname"
        case photo = "photo"
        case logo = "logo"
        case category = "category"
        case note = "note"
        case pricerange = "pricerange"
    }
}

struct Imageobject: Codable {
    let url: String?
    let width: String?
    let height: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case width = "width"
        case height = "height"
    }
}

struct Localbusiness: Codable {
    let address: String?
    let url: String?
    let openinghours: String?
    let photo: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case url = "url"
        case openinghours = "openinghours"
        case photo = "photo"
        case description = "description"
    }
}

struct Person: Codable {
    let location: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case url = "url"
    }
}

struct Videoobject: Codable {
    let url: String?
    let name: String?
    let description: String?
    let paid: String?
    let channelid: String?
    let videoid: String?
    let duration: String?
    let unlisted: String?
    let thumbnailurl: String?
    let embedurl: String?
    let playertype: String?
    let width: String?
    let height: String?
    let isfamilyfriendly: String?
    let regionsallowed: String?
    let interactioncount: String?
    let datepublished: String?
    let genre: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case name = "name"
        case description = "description"
        case paid = "paid"
        case channelid = "channelid"
        case videoid = "videoid"
        case duration = "duration"
        case unlisted = "unlisted"
        case thumbnailurl = "thumbnailurl"
        case embedurl = "embedurl"
        case playertype = "playertype"
        case width = "width"
        case height = "height"
        case isfamilyfriendly = "isfamilyfriendly"
        case regionsallowed = "regionsallowed"
        case interactioncount = "interactioncount"
        case datepublished = "datepublished"
        case genre = "genre"
    }
}

struct Queries: Codable {
    let request: [NextPage]?
    let nextPage: [NextPage]?
    
    enum CodingKeys: String, CodingKey {
        case request = "request"
        case nextPage = "nextPage"
    }
}

struct NextPage: Codable {
    let title: String?
    let totalResults: String?
    let searchTerms: String?
    let count: Int?
    let startIndex: Int?
    let inputEncoding: String?
    let outputEncoding: String?
    let safe: String?
    let cx: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case totalResults = "totalResults"
        case searchTerms = "searchTerms"
        case count = "count"
        case startIndex = "startIndex"
        case inputEncoding = "inputEncoding"
        case outputEncoding = "outputEncoding"
        case safe = "safe"
        case cx = "cx"
    }
}

struct SearchInformation: Codable {
    let searchTime: Double?
    let formattedSearchTime: String?
    let totalResults: String?
    let formattedTotalResults: String?
    
    enum CodingKeys: String, CodingKey {
        case searchTime = "searchTime"
        case formattedSearchTime = "formattedSearchTime"
        case totalResults = "totalResults"
        case formattedTotalResults = "formattedTotalResults"
    }
}

struct URLClass: Codable {
    let type: String?
    let template: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case template = "template"
    }
}

struct Error : Codable {
    let code : Int
}
