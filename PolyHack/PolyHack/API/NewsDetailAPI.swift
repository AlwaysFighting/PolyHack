import Foundation

// MARK: - NewsDetailAPI
struct NewsDetailAPI: Codable {
    let code: Int?
    let message: String?
    let data: NewsDetailDataClass?
}

// MARK: - DataClass
struct NewsDetailDataClass: Codable {
    let news_id: Int?
    let title, content, source, published_at: String?
    let author: String?
    let image_url: String?

    enum CodingKeys: String, CodingKey {
        case news_id
        case title, content, source
        case published_at
        case author
        case image_url
    }
}

