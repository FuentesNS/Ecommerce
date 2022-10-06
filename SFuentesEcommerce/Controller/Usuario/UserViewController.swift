//
//  UserViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 22/09/22.
//

import UIKit
import SwipeCellKit

class UserViewController: UITableViewController {
    
    var usuarios: [Usuario] = []
    var usuario = Usuario()
    
    var isLoadingViewController = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoadingViewController = true
        ViewLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingViewController{
            isLoadingViewController = false
        } else{
            ViewLoadSetup()
        }
    }
    
    func ViewLoadSetup(){
        loadData()
        
        tableView.register(UINib(nibName: "UsuarioCell", bundle: nil), forCellReuseIdentifier: "UsuarioCell")
    }

    
    
    func loadData()
    {
        do{
            var result = try! Usuario.GetAll()
            if result.Correct!{
                usuarios = result.Objects as! [Usuario]
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
        return usuarios.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        
        cell.delegate = self

    
        let usuario : Usuario = usuarios[indexPath.row]
        
        cell.NameLabel.text = usuario.Nombre
        cell.FirstNameLabel.text = usuario.ApellidoPaterno
        cell.LastNameLabel.text = usuario.ApellidoMaterno
        cell.EmailLabel.text = usuario.Email
        cell.PasswordLabel.text = usuario.Password
        cell.UserNameLabel.text = usuario.UserName
        
        //cell.textLabel?.text = usuario.Nombre
        
        return cell
    }
    
    
  
    
}



extension UserViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .left{
            //guard orientation == .left else{ return nil }
            
            let UpdateAction = SwipeAction(style: .default, title: "Actualizar"){ action, indexPath in
                
                self.usuario = self.usuarios[indexPath.row]
                self.performSegue(withIdentifier: "UsuarioSegues", sender: self)
                
            }
            return[UpdateAction]

        } else {
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                let usuario: Usuario = self.usuarios[indexPath.row]
                Usuario.Delete(idUsuario: usuario.IdUsuario!)
                self.loadData()
                
            }
            return[deleteAction]
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UsuarioSegues"{
            
            var UserViewController = segue.destination as? ViewController
            UserViewController?.IdUsuario = self.usuario.IdUsuario!
            
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




