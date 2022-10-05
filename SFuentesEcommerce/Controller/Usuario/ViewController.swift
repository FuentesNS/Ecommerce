//
//  ViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 20/09/22.
//

import UIKit

class ViewController: UIViewController {

    var IdUsuario : Int = 0

    @IBOutlet weak var NameInput: UITextField!
    
    @IBOutlet weak var ApellidoPaternoInput: UITextField!
        
    @IBOutlet weak var ApellidoMaternoInput: UITextField!
    
    @IBOutlet weak var NameUserInput: UITextField!
    
    @IBOutlet weak var EmailInput: UITextField!
    
   
    @IBOutlet weak var PasswordInput: UITextField!
   
    
    
    @IBOutlet weak var ActionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Validate()
    }

    
    /*@IBAction func AddUser() {
        let usuario = Usuario()
        
        usuario.UserName = NameUserInput.text
        usuario.Nombre = NameInput.text!
        usuario.ApellidoPaterno = ApellidoPaternoInput.text!
        usuario.ApellidoMaterno = ApellidoMaternoInput.text!
        usuario.Email = EmailInput.text!
        usuario.Password = PasswordInput.text!
        
        Usuario.Add(usuario)
    }*/
    
    
    @IBAction func ActionButton(_ sender: UIButton) {
        let usuario = Usuario()
        var result = Result()
        
        usuario.IdUsuario = IdUsuario
        usuario.UserName = NameUserInput.text
        usuario.Nombre = NameInput.text!
        usuario.ApellidoPaterno = ApellidoPaternoInput.text!
        usuario.ApellidoMaterno = ApellidoMaternoInput.text!
        usuario.Email = EmailInput.text!
        usuario.Password = PasswordInput.text!
        
        //let textButton = sender.currentTitle
                
        if sender.titleLabel?.text == "Agregar"{
            //Usuario.Add(usuario)
            result = try! Usuario.Add(usuario)
            if result.Correct!{
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Ocurrio Un eroro al generar el usuario")
            }
        } else if sender.titleLabel?.text == "Actualizar"{
            Usuario.Update(usuario)
        }
    }
    
    
    func Validate(){
        if IdUsuario != 0{
            let result: Result = Usuario.GetById(idUsuario: IdUsuario)
            
            if result.Correct!{
                let usuario = result.Object as! Usuario
                NameUserInput.text = usuario.UserName
                NameInput.text = usuario.Nombre
                ApellidoPaternoInput.text = usuario.ApellidoPaterno
                ApellidoMaternoInput.text = usuario.ApellidoMaterno
                EmailInput.text = usuario.Email
                PasswordInput.text = usuario.Password
                
                ActionButton.setTitle("Actualizar", for: .normal)
                ActionButton.backgroundColor = .yellow
            }else{
                ActionButton.setTitle("Agregar", for: .normal)
                ActionButton.backgroundColor = .green
            }
        }
    }
    
    
    
   /* @IBAction func Update() {
        Usuario.Update(usuario)
    }*/
    
    
}

