import UIKit

class SplashVC: UIViewController {
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(transitionToNextScreen), userInfo: nil, repeats: false)
    }
    
    @objc func transitionToNextScreen() {
          let storyboard = UIStoryboard(name: "Main", bundle:nil)
          let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            loginViewController.modalPresentationStyle = .fullScreen
          self.present(loginViewController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
