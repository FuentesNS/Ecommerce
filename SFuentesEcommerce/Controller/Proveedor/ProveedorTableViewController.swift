//
//  ProveedorTableViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 17/10/22.
//

import UIKit
import SwipeCellKit

class ProveedorTableViewController: UITableViewController {
    
    var result = Result()
    var proveedores:  [Proveedor] = []
    var proveedor = Proveedor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
        
        tableView.register(UINib(nibName: "ProveedorViewCell", bundle: nil), forCellReuseIdentifier: "ProveedorCell")
    }
    
    func LoadData(){
        do{
            result = try! Proveedor.GetAll()
            if result.Correct!{
                proveedores = result.Objects as! [Proveedor]
                tableView.reloadData()
            }
        }catch{
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
        return proveedores.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProveedorCell", for: indexPath) as! ProveedorViewCell
        
        cell.delegate = self
        
        let proveedor: Proveedor = proveedores[indexPath.row]
        
        cell.NombreLabel.text = proveedor.Nombre
        cell.TelefonoLabel.text = proveedor.Telefono
        
        return cell
    }
    
}

extension ProveedorTableViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .left{
            let updaeAction = SwipeAction(style: .default, title: "Actualizar"){ action, indexPath in
                
                //Send to view update
                self.proveedor = self.proveedores[indexPath.row]
                self.performSegue(withIdentifier: "ProveedorSegues", sender: self)
            }
            return[updaeAction]
        }else if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Eliminar"){action, indexPath in
                
                
                //Implempent Delete method
                let proveedor : Proveedor = self.proveedores[indexPath.row]
                Proveedor.Delete(proveedor.IdProveedor!)
                self.LoadData()
            }
            return[deleteAction]
        }
        return[]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ProveedorSegues"{
                
                let proveedorViewController = segue.destination as? ProveedorViewController
                proveedorViewController?.IdProveedor = self.proveedor.IdProveedor!
                
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


