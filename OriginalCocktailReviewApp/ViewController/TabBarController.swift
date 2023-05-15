import UIKit

@available(iOS 13.0, *)
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        // タブバーの背景色を設定
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        // UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する。
        self.delegate = self
    }
    
}
