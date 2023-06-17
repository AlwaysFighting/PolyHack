import UIKit

class HomeVC: UIViewController {

    // MARK: - Variable
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    
    
    
    
    // MARK: - IBOutlet

    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
    
        
    }

    // MARK: - Func
    func UI() {
        // tag UIView
        tagView.layer.cornerRadius = 12.0
        
    }
    
    
    
    
    // MARK: - IBAction
    
    

    
    // MARK: - @Objc

}
