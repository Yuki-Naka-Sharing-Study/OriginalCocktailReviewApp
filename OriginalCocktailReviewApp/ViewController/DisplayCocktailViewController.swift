import UIKit
import RealmSwift

class DisplayCocktailViewController: UIViewController,UITableViewDelegate {
    
    private let realm = try! Realm()
    var cocktail: Cocktail!
    
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailMakeLabel: UILabel!
    @IBOutlet weak var cocktailReviewLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCocktail(cocktail)
        
    }
    
    @IBAction func deleteCocktailData(_ sender: Any) {
        // データベースから削除する
        try! realm.write {
            
            self.realm.delete(self.cocktail)
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func Close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    // CocktailImageTableViewCell から参考にしたコード
    func setCocktail(_ cocktail: Cocktail) {
        
        if cocktail.image != nil {
            
            let imageData = UIImage(data: cocktail.image!)!
            cocktailImageView.image = imageData
            
        } else {
            
            print("There is no image...")
            
        }
        
        // outlet接続をしたLabelにカクテルのタイトルを表示する処理
        self.cocktailNameLabel.text = "\(cocktail.name)"
        self.cocktailReviewLabel.text = "\(cocktail.review)"
        
    }
    
}
