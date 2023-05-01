import UIKit
import Cosmos
import RealmSwift
import IQKeyboardManagerSwift

class DisplayCocktailViewController: UIViewController,UITableViewDelegate {
    
    private let realm = try! Realm()
    var cocktail: Cocktail!
    
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailMakeLabel: UILabel!
    @IBOutlet weak var cocktailReviewLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCocktail(cocktail)
        // スター半分の評価ができるようにする
        cosmosView.settings.fillMode = .half
        
    }
    
    @IBAction func deleteCocktailData(_ sender: Any) {
        
        let alert = UIAlertController(title: "カクテルを削除しますが宜しいでしょうか？", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "削除", style: .destructive, handler: { _ in
            
            try! self.realm.write {
                
                self.realm.delete(self.cocktail)
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
        self.cocktailMakeLabel.text = "\(cocktail.make)"
//        self.cosmosView.rating = Double(cocktail.cosmos)
        
    }
    
}
