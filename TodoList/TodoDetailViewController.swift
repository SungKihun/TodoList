//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by 성기훈 on 2021/09/30.
//

import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {

    weak var delegate: TodoDetailViewControllerDelegate?
    
    @IBOutlet var lowButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var highButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedTodoList: TodoList?
    
    var priority: PriorityLevel?
    
    @IBOutlet var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            
            priority = PriorityLevel(rawValue: hasData.priorityLevel)
            
            makePriorityButtonDesign()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highButton.layer.cornerRadius = highButton.bounds.height / 2
    }

    @IBAction func setPriority(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        
        makePriorityButtonDesign()
    }
    
    func makePriorityButtonDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    
    @IBAction func saveTodo(_ sender: Any) {
        
        if selectedTodoList != nil {
            updateTodo()
        } else {
            saveTodo()
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    func saveTodo() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {
            return
        }
        
        object.title = titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        
        object.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()

    }
    
    func updateTodo() {
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }

        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.priorityLevel = self.priority?.rawValue ?? PriorityLevel.level1.rawValue
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()

        } catch {
            print(error)
        }
        
    }
    
    @IBAction func deleteTodo(_ sender: Any) {
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }

        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadedData.first {
                context.delete(loadFirstData)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
            }
        } catch {
            print(error)
        }

        delegate?.didFinishSaveData()
        
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
