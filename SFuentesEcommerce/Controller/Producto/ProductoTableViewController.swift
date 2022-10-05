//
//  ProductoTableViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import UIKit
import SwipeCellKit

class ProductoTableViewController: UITableViewController {
    
    var productos: [Producto] = []
    var producto = Producto()
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
        tableView.register(UINib(nibName: "ProductoCell", bundle: nil), forCellReuseIdentifier: "ProductoCell")
    }
    
    func LoadData(){
        do{
            result = try! Producto.GetAll()
            if result.Correct!{
                productos = result.Objects as! [Producto]
                tableView.reloadData()
            }
        } catch{
            print("OCurrio un error")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
        cell.delegate = self
        
        let producto: Producto = productos[indexPath.row]
        
        cell.NameLabel.text = producto.Nombre
        cell.UnitPriceLabel.text = String(producto.PrecioUnitario!)
        cell.StockLabel.text = String(producto.Stock!)
        cell.DescriptionLabel.text = String(producto.Descripcion!)
        
        return cell
    }
    
}

extension ProductoTableViewController:SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
     
        if orientation == .left{
            let updateAction = SwipeAction(style: .default, title: "Actualizar"){ action, indexPath in
                
                // Falta implemnatra bien la consulta sql
                
                self.producto = self.productos[indexPath.row]
                self.performSegue(withIdentifier: "ProductoSegues", sender: self)
                
            }
            return[updateAction]
        }
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Eliminar"){action, indexPath in
                
                let producto: Producto = self.productos[indexPath.row]
                Producto.Delete(producto.IdProducto!)
                self.LoadData()
                
            }
            return[deleteAction]
        }
        return[]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductoSegues"{
            
            let producutoViewController = segue.destination as? ProductoViewController
            producutoViewController?.IdProducto = self.producto.IdProducto!
            
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


