//
//  DepartamentoViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 26/10/22.
//

import UIKit
import iOSDropDown

class DepartamentoViewController: UIViewController {
    
    
    @IBOutlet weak var ImageDepartamento: UIImageView!
    @IBOutlet weak var NombreInput: UITextField!
    @IBOutlet weak var AreaDropDown: DropDown!
    @IBOutlet weak var OptionButton: UIButton!
    
    
    var departamentos: [Departamento] = []
    var arrayArea: [String] = []
    var arrayIdArea: [Int] = []
    var area: [Area] = []
    
    var IdDepartamento: Int = 0
    var IdArea: Int = 0
    
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validate()
        // Do any additional setup after loading the view.
        
        LoadDataDepartamento()
        AreaDropDown.optionArray = arrayArea
        AreaDropDown.optionIds = arrayIdArea
        
        AreaDropDown.didSelect { selectedText, index, id in
            self.IdArea = id
        }
    }
    
    @IBAction func OptionButton(_ sender: UIButton) {
        let departamento = Departamento()
        var result = Result()
        
        
        departamento.Nombre = NombreInput.text!
        departamento.area.Nombre = AreaDropDown.text!
        
        if sender.titleLabel?.text == "Agregar"{
            result = try! Departamento.Add(departamento)
            if result.Correct!{
                self.dismiss(animated: true, completion: nil)
            } else{
                print("Ocurrio un fallo al agregar el Departamento")
            }
            
        }else if sender.titleLabel?.text == "Actualizar"{
            Departamento.Update(departamento)
            if result.Correct!{
                print("Se actualizo el Departamento")
                //self.dismiss(animated: true, completion: nil)
            } else{
                print("Ocurrio un fallo al actualizar el Departamento")
            }
        }
    }
    
    
    func Validate(){
        if IdDepartamento != 0{
            let result: Result = Departamento.GetByIdArea(IdDepartamento)
            
            if result.Correct!{
                let departamento = result.Object as! Departamento
                NombreInput.text = departamento.Nombre

                AreaDropDown.text = String(departamento.area.Nombre)
                IdArea = departamento.area.IdArea!
                
                IdArea = departamento.area.IdArea!
                
                OptionButton.setTitle("Actualizar", for: .normal)
                OptionButton.backgroundColor = .yellow
            }else{
                OptionButton.setTitle("Agregar", for: .normal)
                OptionButton.backgroundColor = .green
            }
        }
    }
    
    func LoadDataDepartamento(){
            result = try! Area.GetAll()
            if result.Correct!{
                area = result.Objects as! [Area]
                for departamento in departamentos {
                    
                    arrayArea.append(departamento.area.Nombre)
                    arrayIdArea.append(departamento.area.IdArea!)
                    
                }
            }
        }

}
