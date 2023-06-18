import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
