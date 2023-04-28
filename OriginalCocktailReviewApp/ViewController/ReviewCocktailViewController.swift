import UIKit
import RealmSwift

class ReviewCocktailViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let realm = try! Realm()
    private var cocktailArray = try! Realm().objects(Cocktail.self).sorted(byKeyPath: "date", ascending: true)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // カスタムセルを登録する
        let nib = UINib(nibName: "CocktailImageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CocktailImageTableViewCell")
        setupView()
        
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    private func setupView() {
        
        tableView.fillerRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DisplayCocktailViewController:DisplayCocktailViewController = segue.destination as! DisplayCocktailViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            DisplayCocktailViewController.cocktail = cocktailArray[indexPath!.row]
        }
        
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
        performSegue(withIdentifier: "cellSegue",sender: nil)}
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle { .delete }
    
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
