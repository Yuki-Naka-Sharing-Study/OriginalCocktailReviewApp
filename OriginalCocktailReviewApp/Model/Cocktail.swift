import RealmSwift

class Cocktail: Object {
    // カクテルの画像
    @objc dynamic var image: Data? = nil
    // カクテルの作り方
    @objc dynamic var make = ""
    // カクテルの星５段階評価 (新しく追加）
    @objc dynamic var cosmos = 0
    // カクテルの感想
    @objc dynamic var review = ""
    // カクテルの名前
    @objc dynamic var name = ""
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
