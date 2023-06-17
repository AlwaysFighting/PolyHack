import Foundation

// MARK: - NewsAPI
struct EntireNewsAPI: Codable {
    let code: Int?
    let message: String?
    let data: [EntireNewsDatum]?
}

struct EntireNewsDatum: Codable {
    let newsID: Int?
    let title: String?
    let source: EntireSource?
    let publishedAt: String?
    let author: String?
    let imageURL: String?

    enum EntireCodingKeys: String, CodingKey {
        case newsID = "news_id"
        case title, source
        case publishedAt = "published_at"
        case author
        case imageURL = "image_url"
    }
}

enum EntireSource: String, Codable {
    case cnn = "CNN"
    case time = "Time"
}

