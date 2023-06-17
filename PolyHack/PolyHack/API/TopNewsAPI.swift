import Foundation

// MARK: - TopNewsAPI
struct TopNewsAPI: Codable {
    let code: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let newsID: Int?
    let title, source, publishedAt, author: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case newsID = "news_id"
        case title, source
        case publishedAt = "published_at"
        case author
        case imageURL = "image_url"
    }
}

