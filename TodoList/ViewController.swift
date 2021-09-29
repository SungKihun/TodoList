//
//  ViewController.swift
//  TodoList
//
//  Created by 성기훈 on 2021/09/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
        self.makeNavigationBar()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    func makeNavigationBar() {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(red: 30/255, green: 40/255, blue: 50/255, alpha: 0.3)
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance
    }

    @objc func addNewTodo() {
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        return cell
    }
    
    
}
