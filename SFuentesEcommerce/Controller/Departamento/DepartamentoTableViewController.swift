//
//  DepartamentoTableViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 26/10/22.
//

import UIKit
import SwipeCellKit

class DepartamentoTableViewController: UITableViewController {
    
    var result = Result()
    var departamentos : [Departamento] = []
    var departamento = Departamento()
    
    var IdDepartamento: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadData()
        
        tableView.register(UINib(nibName: "DepartamentoViewCell", bundle: nil), forCellReuseIdentifier: K.NameCellDepartamento)
    }
    
    func LoadData(){
        do{
            result = try! Departamento.GetAll()
            if result.Correct!{
                departamentos = result.Objects as! [Departamento]
                tableView.reloadData()
            }
        } catch {
            print("Ocurrio un error")
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return departamentos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.NameCellDepartamento, for: indexPath) as! DepartamentoViewCell
        
        cell.delegate = self
        
        let departamento : Departamento = departamentos[indexPath.row]
        
        cell.NombreLabel.text = departamento.Nombre
        cell.AreaLabel.text = departamento.area.Nombre
        
        
        return cell
    }
    
}

extension DepartamentoTableViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .left {
            let updaeAction = SwipeAction(style: .default, title: "Actualizar"){ action, indexPath in
                
                //Send to view update
                self.departamento = self.departamentos[indexPath.row]
                self.performSegue(withIdentifier: "DepartamentoSegues", sender: self)
            }
            return[updaeAction]
        } else if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Eliminar"){action, indexPath in
                
                
                //Implempent Delete method
                let departamento : Departamento = self.departamentos[indexPath.row]
                Departamento.Delete(departamento.IdDepartamento!)
                self.LoadData()
            }
            return[deleteAction]
        }
        return[]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartamentoSegues"{
            
            let departamentoViewController = segue.destination as? DepartamentoViewController
            departamentoViewController?.IdDepartamento = self.departamento.IdDepartamento!
            
        }
    }
    
    
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


