//
//  ProveedorViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 17/10/22.
//

import UIKit

class ProveedorViewController: UIViewController {
    
    @IBOutlet weak var NombreInput: UITextField!
    @IBOutlet weak var TelefonoInput: UITextField!
    @IBOutlet weak var OptionButton: UIButton!
    
    var IdProveedor: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validate()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func OptionButton(_ sender: UIButton) {
        
        let proveedor = Proveedor()
        var result = Result()
        
        
        proveedor.Nombre = NombreInput.text
        proveedor.Telefono = TelefonoInput.text
        
        if sender.titleLabel?.text == "Agregar"{
            result = try! Proveedor.Add(proveedor)
            if result.Correct!{
                self.dismiss(animated: true, completion: nil)
            } else{
                print("Ocurrio un fallo al agregar el Proveedor")
            }
            
        }else if sender.titleLabel?.text == "Actualizar"{
            Proveedor.Update(proveedor)
            if result.Correct!{
                print("Se actualizo el Proveedor")
                //self.dismiss(animated: true, completion: nil)
            } else{
                print("Ocurrio un fallo al actualizar el Proveedor")
            }
        }
    }
  
    func Validate(){
        if IdProveedor != 0{
            let result: Result = Proveedor.GetById(IdProveedor)
            
            if result.Correct!{
                let proveedor = result.Object as! Proveedor
                NombreInput.text = proveedor.Nombre
                TelefonoInput.text = proveedor.Telefono
                
                OptionButton.setTitle("Actualizar", for: .normal)
                OptionButton.backgroundColor = .yellow
            }else{
                OptionButton.setTitle("Agregar", for: .normal)
                OptionButton.backgroundColor = .green
            }
        }
    }
    

}
