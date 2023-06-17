import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Variable
    let newsFetcher = FetchNews()
    var TopnewsData: TopNewsAPI?
    
    var entireNewsArry: [EntireNewsDatum] = []
    var entireNewsAPI: EntireNewsAPI?
    
    // MARK: - IBOutlet
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerAuthor: UILabel!
    @IBOutlet weak var bannerPublished: UILabel!
    
    @IBOutlet weak var entireTableView: UITableView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
        delegate()
        fetchNewsData()
        fetchEntireNewsData()
    }
    
    func delegate() {
        self.entireTableView.delegate = self
        self.entireTableView.dataSource = self
    }
    
    // MARK: - Func
    func UI() {
        // tag UIView
        tagView.layer.cornerRadius = 12.0
        
        // Image
        bannerImage.contentMode = .scaleAspectFill
        bannerImage.clipsToBounds = true
        
        bannerAuthor.textColor = .white
        bannerPublished.textColor = .white
        bannerTitle.textColor = .white
    }
    
    func fetchNewsData() {
        guard let url = URL(string: TOP_NEWS_API) else {
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
                let newsAPI = try JSONDecoder().decode(TopNewsAPI.self, from: data)
                self?.TopnewsData = newsAPI
                
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    fileprivate func extractedFunc(_ newsData: TopNewsAPI) {
        if let dateString = newsData.data?.publishedAt {
            let formattedString = formatDateString(dateString)
            self.bannerPublished.text = "Published \(formattedString)"
        } else {
            self.bannerPublished.text = ""
        }
    }
    
    func updateUI() {
        
        guard let newsData = self.TopnewsData else {
            return
        }
        
        if let imageURL = newsData.data?.imageURL, let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.bannerImage.image = image
                        self.bannerImage.frame.size.height = 294
                    }
                }
            }
        }
        
        if let title = newsData.data?.title {
            self.bannerTitle.text = title
        }
        
        if let author = newsData.data?.author, let source = newsData.data?.source {
            self.bannerAuthor.text = "\(author), \(source)"
        } else {
            self.bannerAuthor.text = "Unknown"
        }
        
        if let dateString = newsData.data?.publishedAt {
            let formattedString = formatDateString(dateString)
            self.bannerPublished.text = "Published \(formattedString)"
        } else {
            self.bannerPublished.text = ""
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
    
    func fetchEntireNewsData() {
        
        guard let url = URL(string: ENTIRE_DETAIL_URL) else {
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
                let newsAPI = try JSONDecoder().decode(EntireNewsAPI.self, from: data)
                self?.entireNewsAPI = newsAPI
                
                DispatchQueue.main.async {
                    // self?.entireNewsUI()
                    self?.entireTableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // MARK: - IBAction
    
    
    
    
    // MARK: - @Objc
    
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.entireNewsAPI?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
    
        
        guard let newsData = self.entireNewsAPI?.data else {
            return cell
        }
        
        if indexPath.row < newsData.count {
            let news = newsData[indexPath.row]
            cell.newsTitle.text = news.title
            
            if news.author != nil  && news.published_at != nil {
                cell.newsTime.text = "By \(String(describing: news.author!)), \(String(describing: news.source!)) | \(formatDateString(news.published_at!))"
            } else if news.author == nil && news.published_at != nil {
                cell.newsTime.text = "\(String(describing: news.source!)) | \(formatDateString(news.published_at!))"
            } else if news.author != nil && news.published_at == nil {
                cell.newsTime.text = "\(String(describing: news.author!))"
            } else {
                cell.newsTime.text = ""
            }
        
                cell.newsImage.image = nil
                cell.newsImage.contentMode = .center
                cell.newsImage.backgroundColor = .lightGray
                cell.newsImage.frame.size.height = 104
                cell.newsImage.frame.size.width = 104
                cell.newsImage.clipsToBounds = true
                cell.newsImage.layer.cornerRadius = 18
                
            if let imageURL = news.image_url, let url = URL(string: imageURL) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            let image = UIImage(data: data)
                            
                            DispatchQueue.main.async {
                                if cell.newsImage.image == nil {
                                    cell.newsImage.contentMode = .scaleAspectFill
                                    cell.newsImage.image = image
                                }
                            }
                        }
                    }
                }
        }
        
        return cell
    }
    
    
}
