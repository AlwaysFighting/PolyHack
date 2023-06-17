import Foundation

// MARK: - NewsAPI
struct EntireNewsAPI: Codable {
    let code: Int?
    let message: String?
    let data: [EntireNewsDatum]?
}

struct EntireNewsDatum: Codable {
    let news_id: Int?
    let title: String?
    let source: EntireSource?
    let published_at: String?
    let author: String?
    let image_url: String?

    enum EntireCodingKeys: String, CodingKey {
        case news_id
        case title, source
        case published_at
        case author
        case image_url
    }
}

enum EntireSource: String, Codable {
    case cnn = "CNN"
    case time = "Time"
}

