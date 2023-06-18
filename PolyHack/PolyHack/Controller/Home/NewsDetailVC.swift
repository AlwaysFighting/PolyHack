import UIKit

class NewsDetailVC: UIViewController {
    
    // MARK: - Var
    let fetchNews = FetchNews()
    var detailnewsData: NewsDetailAPI?
    var selectedIndex: Int = 1 // Check Index Row Number
    
    // MARK: - @IBOutlet
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContents: UILabel!
    @IBOutlet weak var scrollView: UIView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedIndex)
        UI()
        fetchNewsData()
    }
    
    func UI() {
        // Image
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
    }
    
    // MARK: - UI
    func fetchNewsData() {
        guard let url = URL(string: fetchNews.detailNews(id: selectedIndex)) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let newsAPI = try JSONDecoder().decode(NewsDetailAPI.self, from: data)
                self?.detailnewsData = newsAPI
                
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func updateUI() {
        
        guard let newsData = self.detailnewsData else {
            return
        }
        
        if let imageURL = newsData.data?.image_url, let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.newsImage.image = image
                        self.newsImage.frame.size.height = 245
                    }
                }
            }
        }
        
        
        if let title = newsData.data?.title {
            self.newsTitle.text = title
        }
        
        if let author = newsData.data?.author, let source = newsData.data?.source {
            self.newsAuthor.text = "\(author), \(source)"
        } else {
            self.newsAuthor.text = ""
        }
        
        if let dateString = newsData.data?.published_at {
            let formattedString = formatDateString(dateString)
            self.newsDate.text = "Published \(formattedString)"
        } else {
            self.newsDate.text = ""
        }
        
        if let content = newsData.data?.content {
            self.newsContents.text = content
        }
        
    }
    
    
    func formatDateString(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = formatter.date(from: dateString) {
            let currentDate = Date()
            
            if date < currentDate {
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter.string(from: date)
            } else {
                formatter.dateFormat = "h:mm a"
                return formatter.string(from: date)
            }
        }
        return ""
    }
}
