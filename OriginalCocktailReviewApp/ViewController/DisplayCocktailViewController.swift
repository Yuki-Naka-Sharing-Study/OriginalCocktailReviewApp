import UIKit
import RealmSwift
import IQKeyboardManagerSwift

class DisplayCocktailViewController: UIViewController,UITableViewDelegate {
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet private weak var cocktailNameLabel: UILabel!
    @IBOutlet private weak var cocktailRatingImageView: UIImageView!
    @IBOutlet private weak var cocktailReviewLabel: UILabel!
    @IBOutlet private weak var cocktailMakeLabel: UILabel!
    
    private let realm = try! Realm()
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCocktail(cocktail)
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
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    // CocktailImageTableViewCell から参考にしたコード
    private func setCocktail(_ cocktail: Cocktail) {
        if cocktail.image != nil {
            let imageData = UIImage(data: cocktail.image!)!
            cocktailImageView.image = imageData
        } else {
            print("There is no image...")
        }
        
        if cocktail.image2 != nil {
            let imageData = UIImage(data: cocktail.image2!)!
            cocktailRatingImageView.image = imageData
        } else {
            print("There is no image...")
        }
        // outlet接続をしたLabelにカクテルのタイトルを表示する処理
        self.cocktailNameLabel.text = "\(cocktail.name)"
        self.cocktailReviewLabel.text = "\(cocktail.review)"
        self.cocktailMakeLabel.text = "\(cocktail.make)"
    }
}
