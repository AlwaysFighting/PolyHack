import Foundation

// MARK: - NewsDetailAPI
struct NewsDetailAPI: Codable {
    let code: Int?
    let message: String?
    let data: NewsDetailDataClass?
}

// MARK: - DataClass
struct NewsDetailDataClass: Codable {
    let newsID: Int?
    let title, content, source, publishedAt: String?
    let author: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case newsID
        case title, content, source
        case publishedAt
        case author
        case imageURL
    }
}

