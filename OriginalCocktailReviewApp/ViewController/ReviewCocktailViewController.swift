import UIKit
import RealmSwift

class ReviewCocktailViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let realm = try! Realm()
    private var cocktailArray = try! Realm().objects(Cocktail.self).sorted(byKeyPath: "date", ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DisplayCocktailViewController = segue.destination as! DisplayCocktailViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow,
           segue.identifier == "cellSegue" {
            DisplayCocktailViewController.cocktail = cocktailArray[indexPath.row]
        }
    }
    private func setupView() {
        // カスタムセルを登録する
        let nib = UINib(nibName: "CocktailImageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CocktailImageTableViewCell")
        
        if #available(iOS 15.0, *) {
            tableView.fillerRowHeight = UITableView.automaticDimension
        } else {
            // Fallback on earlier versions
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReviewCocktailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cellに値を設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailImageTableViewCell", for: indexPath) as! CocktailImageTableViewCell
        cell.setCocktail(cocktailArray[indexPath.row])
        
        return cell
    }
    
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue",sender: nil)
    }
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle { .delete
    }
    
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // データベースから削除する
            try! realm.write {
                self.realm.delete(self.cocktailArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
