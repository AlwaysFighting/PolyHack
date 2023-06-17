import Foundation

// API URL
let BASE_URL : String  = "http://localhost:8080"

let NEWS_DETAIL_URL : String = "\(BASE_URL)/news/detail"
let TOP_NEWS_API : String = "\(BASE_URL)/news/top"


class fetchNews() {
    
    // Detail news
    func fetchDetailNews(url: String, id: Int) {
        guard let url = URL(string: "\(NEWS_DETAIL_URL)/\(id)") else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let newsAPI = try JSONDecoder().decode(NewsAPI.self, from: data)
                print(newsAPI)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    // Top News
    func fetchTopNews(url : String) {
        guard let url = URL(string: TOP_NEWS_API) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let newsAPI = try JSONDecoder().decode(NewsAPI.self, from: data)
                print(newsAPI)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
