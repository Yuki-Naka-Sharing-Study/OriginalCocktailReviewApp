import UIKit
import RealmSwift
import CLImageEditor
import IQKeyboardManagerSwift

class RegisterCocktailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    // @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var cocktailImageView: UIImageView!
    @IBOutlet private weak var cocktailMakeTextView: UITextView!
    @IBOutlet private weak var cocktailRatingImageView: UIImageView!
    @IBOutlet private weak var cocktailReviewTextView: UITextView!
    @IBOutlet private weak var cocktailNameTextField: UITextField!
    
    private let realm = try! Realm()
    private var cocktail: Cocktail!
    private var rating: Int = 0 {
        didSet {
            let imageName = "star\(rating)"
            cocktailRatingImageView.image = UIImage(named: imageName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// 画面全体の空いているところをタップしたら呼ばれる
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    /// レビューボタンタップ時に呼ばれる
    @IBAction func ratingButtonTapped(_ sender: UIButton) {
        // rating を更新します。
        if rating == 5 {
            rating = 0
        }
        rating += 1
    }
    /// 登録ボタンタップ時に呼ばれる
    @IBAction func registerCocktail(_ sender: Any) {
        guard let cocktailImage = cocktailImageView.image,
              let cocktailNameText = cocktailNameTextField.text,
              let cocktailRatingImage = cocktailRatingImageView.image,
              let cocktailReviewText = cocktailReviewTextView.text,
              let cocktailMakeText = cocktailMakeTextView.text
        else {
            showErrorAlert()
            return
        }
        saveCocktailData(cocktailImage: cocktailImage,
                         cocktailNameText: cocktailNameText,
                         cocktailRatingImage: cocktailRatingImage,
                         cocktailReviewText: cocktailReviewText,
                         cocktailMakeText: cocktailMakeText)
    }
    
    @IBAction func getImage(_ sender: Any) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true)
        }
    }
    
    private func setupView() {
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "エラーメッセージ",
                                      message:"「カクテルの画像」「カクテルの名前」「カクテルのレビュー」「カクテルの感想」「カクテルの作り方」のいずれかが入力されていません。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func saveCocktailData(cocktailImage: UIImage,
                                  cocktailNameText: String,
                                  cocktailRatingImage: UIImage,
                                  cocktailReviewText: String,
                                  cocktailMakeText: String) {
        
        cocktail = Cocktail()
        let allCocktails = realm.objects(Cocktail.self)
        if allCocktails.count != 0 {
            cocktail.id = allCocktails.max(ofProperty: "id")! + 1
        }
        
        try! realm.write {
            self.cocktail.image = self.cocktailImageView.jpegData(compressionQuality: 1)
            self.cocktail.image2 = self.cocktailRatingImageView.jpegData(compressionQuality: 1)
            self.cocktail.make = self.cocktailMakeTextView
            self.cocktail.review = self.cocktailReviewTextView
            self.cocktail.name = self.cocktailNameTextField
            self.realm.add(self.cocktail, update: .modified)
        }
    }
    
    //     写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 画像加工処理
        if let originalImage = info[.originalImage]as? UIImage,
            let editor = CLImageEditor(image: originalImage) {
            editor.delegate = self
            self.present(editor, animated: true)
        }
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    //     CLImageEditorで加工が終わったときに呼ばれるメソッド
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        // imageViewに画像を渡す
        cocktailImageView.image = image
        editor.dismiss(animated: true, completion: nil)
    }
    //     CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        // CLImageEditor画面を閉じる
        editor.dismiss(animated: true, completion: nil)
    }
}
