import RealmSwift

class Cocktail: Object {
    // カクテルの画像
    @objc dynamic var image: Data? = nil
    // カクテルの作り方
    @objc dynamic var make = ""
    // カクテルの感想
    @objc dynamic var review = ""
    // カクテルの名前
    @objc dynamic var name = ""
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    // カクテルの状態　（０が初期値）
    @objc dynamic var state = 0
    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
