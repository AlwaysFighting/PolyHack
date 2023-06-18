import Foundation

// API URL

let BASE_URL : String  = "http://localhost:8080/news"

let ENTIRE_DETAIL_URL : String = "\(BASE_URL)"
let NEWS_DETAIL_URL : String = "\(BASE_URL)/detail"
let TOP_NEWS_API : String = "\(BASE_URL)/top"


class FetchNews {
    
    func entireNews() {
        guard let url = URL(string: ENTIRE_DETAIL_URL) else {
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
                let newsAPI = try JSONDecoder().decode(EntireNewsAPI.self, from: data)
                print(newsAPI)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    // Detail news API
    func detailNews(id: Int) -> String {
        return  "\(NEWS_DETAIL_URL)/\(id)"
    }

    // Top News API
    func fetchTopNews() {
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
                let newsAPI = try JSONDecoder().decode(TopNewsAPI.self, from: data)
                print(newsAPI)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
