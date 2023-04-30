import UIKit
import Cosmos
import RealmSwift
import CLImageEditor
import IQKeyboardManagerSwift

class RegisterCocktailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailMakeTextView: UITextView!
    @IBOutlet weak var cocktailReviewTextView: UITextView!
    @IBOutlet weak var cocktailNameTextField: UITextField!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    let realm = try! Realm()
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        setup()
    }
    
    private func setup() {
        //星の数の初期表示数(0に設定)
        cosmosView.rating = 0
        
    }
    
//    @IBAction func rateStarsAction(_ sender: UIButton) {
//        //押されたボタンの数に応じて表示する星の数を変更する
//        cosmosView.rating = Double(sender.tag)
//
//    }
    
    @objc func dismissKeyboard(){
        
        view.endEditing(true)
        
    }
    
    @IBAction func registerCocktail(_ sender: Any) {
        
        if cocktailImageView.image == nil || cocktailMakeTextView.text == "" ||
            cocktailReviewTextView.text == "" || cocktailNameTextField.text == "" {
            
            let alert = UIAlertController(title: "エラーメッセージ", message: "「カクテルの画像」「カクテルの作り方」「カクテルの感想」「カクテルの名前」のいずれかが入力されていません。",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        cocktail = Cocktail()
        let allCocktails = realm.objects(Cocktail.self)
        if allCocktails.count != 0 {
            
            cocktail.id = allCocktails.max(ofProperty: "id")! + 1
            
        }
        
        try! realm.write {
            
            self.cocktail.image = self.cocktailImageView.image!.jpegData(compressionQuality: 1)
            self.cocktail.make = self.cocktailMakeTextView.text!
            self.cocktail.review = self.cocktailReviewTextView.text!
            self.cocktail.name = self.cocktailNameTextField.text!
            self.realm.add(self.cocktail, update: .modified)
            
        }
        
    }
    
    @IBAction func getImage(_ sender: Any) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
    }
    
    //     写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
        // 画像加工処理
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            // CLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            // CLImageEditorにimageを渡して、加工画面を起動する。
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            self.present(editor, animated: true, completion: nil)
            
        }
        
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
