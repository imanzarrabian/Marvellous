
import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    var comic: Comic!
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayComicInfos()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func displayComicInfos() {
        titleLabel.text = comic.title
        descriptionLabel.text = comic.description
        isbnLabel.text = comic.isbn
        if comic.price == 0 {
            priceLabel?.text = "FREE"
            priceLabel?.textColor = UIColor(red:0.84, green:0.18, blue:0.18, alpha:1.0)
        } else {
            priceLabel?.text = "$\(comic.price)"
            priceLabel?.textColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
        }

    
        Alamofire.request(.GET, "\(comic.thumbnail)").response { (request, response, data, error) in
            self.comicImageView.image = UIImage(data: data!, scale:1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

