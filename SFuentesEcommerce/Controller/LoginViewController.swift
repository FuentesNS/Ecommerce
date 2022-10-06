//
//  LoginViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 05/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SingUpButton() {
        let email = EmailInput.text!
        let password = PasswordInput.text
        
        let result : Result = Usuario.GetByEmail(email)
        if result.Correct!{
            let usuario = result.Object as! Usuario
            if password == usuario.Password{
                self.performSegue(withIdentifier: "Login", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Error de Contraseña!", message: "La contraseña es incorecta!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Error de Correo!", message: "El correo no existe!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    

}
