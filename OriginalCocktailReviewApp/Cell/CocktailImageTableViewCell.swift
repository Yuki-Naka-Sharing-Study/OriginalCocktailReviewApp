import UIKit

class CocktailImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailRatingImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCocktail(_ cocktail: Cocktail) {
        if let image = cocktail.image, let imageData = UIImage(data: image) {
            cocktailImageView.image = imageData
        } else {
            print("There is no image...")
        }
        
        if let starImage = cocktail.reviewImageData, let imageData = UIImage(data: starImage) {
            cocktailRatingImageView.image = imageData
        } else {
            print("There is no image...")
        }
        // outlet接続をしたLabelにカクテルのタイトルを表示する処理
        self.cocktailNameLabel.text = cocktail.name
        
    }
    
}

