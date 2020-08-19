//
//  ViewController.swift
//  ToDoList
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var ListaDeLtarefas: [String] = []
    let listaKey = "chaveLista"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        if let lista = UserDefaults.standard.value(forKey: listaKey) as? [String]{
            ListaDeLtarefas.append(contentsOf: lista)
            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func addList(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa",
                                      message: "Adicionar nova tarefa",
                                      preferredStyle:.alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first, let texto = textField.text{
                self.ListaDeLtarefas.append(texto)
                UserDefaults.standard.set(self.ListaDeLtarefas, forKey: self.listaKey)
                self.tableView.reloadData()
            }
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        
        alert.addTextField()
        present(alert, animated: true)
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ListaDeLtarefas.count
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ListaDeLtarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            ListaDeLtarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.ListaDeLtarefas, forKey: self.listaKey)
        }
    }
    
}


