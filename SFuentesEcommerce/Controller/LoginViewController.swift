//
//  LoginViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 05/10/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton() {

        ValidateFields()
        
        if let email = EmailInput.text, let password = PasswordInput.text{
            Auth.auth().signIn(withEmail: email, password: password){authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                } else{
                    self.performSegue(withIdentifier: "Login", sender: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error de Campos", message: "El correo o la contraeña no exixten!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ValidateFields(){
        let email = EmailInput.text!
        let password = PasswordInput.text!
        if email == "", password == ""{
            let alert = UIAlertController(title: "Error de Campos!", message: "Los campos no pueden quedar Vacios!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if email == ""{
            let alert = UIAlertController(title: "Error de Correo", message: "El correo no puede quedar vacio!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if password == ""{
            let alert = UIAlertController(title: "Error de Contraseña", message: "La contraseña no puede quedar vacia!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}



