import RealmSwift

class Cocktail: Object {
    // カクテルの画像
    @objc dynamic var image: Data? = nil
    // カクテルの名前
    @objc dynamic var name = ""
    // カクテルの星５段階評価 (新しく追加）
    @objc dynamic var image2: Data? = nil
    // カクテルの感想
    @objc dynamic var review = ""
    // カクテルのレシピ
    @objc dynamic var make = ""
    // カクテルを飲んだ日
    @objc dynamic var date = Date()
    // カクテルの状態　（０が初期値）
    @objc dynamic var state = 0
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
