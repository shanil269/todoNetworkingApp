//
//  TodoVCswift
//  todo
//
//  Created by Muhaimin on 22/7/20.
//  Copyright © 2020 Muhaimin. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var todos = Array<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTodos()
        
    }
    @IBAction func addTodo(_ sender: Any) {
        guard let todoItem = todoItemTxt.text else {
            return
        }
        let todo = Todo(item: todoItem, priority: prioritySegment.selectedSegmentIndex)
        NetworkService.shared.addTodo(todo: todo, onSuccess: { (todos) in
            self.todoItemTxt.text = ""
            self.todos = todos.items
            self.tableView.reloadData()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func getTodos() {
        NetworkService.shared.getTodos(onSuccess: { (todos) in
            self.todos = todos.items
            self.tableView.reloadData()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }

}
extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
