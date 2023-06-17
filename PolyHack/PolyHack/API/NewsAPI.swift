import Foundation

// MARK: - NewsAPI
struct NewsAPI: Codable {
    let code: Int
    let message: String
    let data: [Datum]
}

struct Datum: Codable {
    let newsID: Int
    let title: String
    let source: Source
    let publishedAt: String
    let author: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case newsID = "news_id"
        case title, source
        case publishedAt = "published_at"
        case author
        case imageURL = "image_url"
    }
}

enum Source: String, Codable {
    case cnn = "CNN"
    case time = "Time"
}

