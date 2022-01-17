//
//  SettingsViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Denys Denysenko on 11.01.2022.
//

import UIKit


class SettingsViewController: UITableViewController {
    
    
var answers = [String]()
let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnswer))

        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.tableFooterView = UIView()
        view.backgroundColor = .systemGray5
        answers = defaults.stringArray(forKey: "answers")!
        
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = defaults.stringArray(forKey: "answers")?[indexPath.row]
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            action, indexPath in
            self.answers.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return[deleteAction]
    }
    
    
    
    @objc func addAnswer () {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let saveAnswer = UIAlertAction(title: "Save", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.answers.append(answer)
            self?.defaults.setValue(self?.answers, forKey: "answers")
            print(self?.defaults.array(forKey: "answers")?.count)
            self?.tableView.reloadData()
        }
        ac.addAction(saveAnswer)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
        
       
        
    }

   

}
