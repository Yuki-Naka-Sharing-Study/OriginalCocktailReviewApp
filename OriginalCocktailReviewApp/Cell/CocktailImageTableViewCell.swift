import UIKit

class CocktailImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCocktail(_ cocktail: Cocktail) {
        
        if cocktail.image != nil {
            
            let imageData = UIImage(data: cocktail.image!)!
            cocktailImageView.image = imageData
            
        } else {
            
            print("There is no image...")
            
        }
        
        // outlet接続をしたLabelにカクテルのタイトルを表示する処理
        self.cocktailNameLabel.text = "\(cocktail.name)"
        
    }
    
}

