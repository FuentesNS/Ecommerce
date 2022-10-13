//
//  ProductoController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import UIKit
import VisionKit
import iOSDropDown

class ProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var NombreInput: UITextField!
    @IBOutlet weak var PrecioUnitarioInput: UITextField!
    @IBOutlet weak var StockInput: UITextField!
    //@IBOutlet weak var IdProveedorInput: UITextField!
    //@IBOutlet weak var IdDepartamentoInput: UITextField!
    @IBOutlet weak var DescripcionInput: UITextField!
    @IBOutlet weak var ActionButton: UIButton!
    @IBOutlet weak var PhotoProducto: UIImageView!
    @IBOutlet weak var ProveedorDropDown: DropDown!
    @IBOutlet weak var DepartamentoDropDown: DropDown!
    
    
    var IdProducto : Int = 0
    var IdProveedor: Int = 0
    var IdDepartamento: Int = 0
    var arrayProveedor: [String] = []
    var arrayIdProveedor: [Int] = []
    var arrayDepartamento: [String] = []
    var arrayIdDepartamento: [Int] = []
    var arrayId: [String] = []
    var proveedores: [Proveedor] = []
    var departamentos: [Departamento] = []
    var result = Result()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validate()
        imagePicker.delegate = self
        
        LoadDataProveedor()
        ProveedorDropDown.optionArray = arrayProveedor
        ProveedorDropDown.optionIds = arrayIdProveedor
        
        ProveedorDropDown.didSelect { selectedText, index, id in
            self.IdProveedor = id
        }
        
        
        LoadDataDepartamento()
        DepartamentoDropDown.optionArray = arrayDepartamento
        DepartamentoDropDown.optionIds = arrayIdDepartamento

        DepartamentoDropDown.didSelect { selectedText, index, id in
            self.IdDepartamento = id
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func GetPhoto() {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        } else{
            print("Ocurrio un error al abrir la galeria, o la camara del dispositivo")
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            PhotoProducto.image = image //Obtiene la informacion de la foto y la almacena
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func ActionButton(_ sender: UIButton) {
        
        let producto = Producto()
        
        producto.Nombre = NombreInput.text
        producto.PrecioUnitario = Int(PrecioUnitarioInput.text!)
        producto.Stock = Int(StockInput.text!)
        
        // propiedad de text field
        producto.proveedor.IdProveerdor = IdProveedor
        producto.departamento.IdDepartamento = IdDepartamento
        
        producto.Descripcion = DescripcionInput.text
        
        if sender.titleLabel?.text == "Agregar"{
            // function add product
            //Producto.Add(producto)
            var result = try Producto.Add(producto)
            if result.Correct!{
                print("Producto agregago")
            }else{
                print("Ocurrio un error")
            }
            
        }else if sender.titleLabel?.text == "Actualizar"{
            Producto.Update(producto) 
        }
        
    }
 
    func Validate(){
        if IdProducto != 0{
            let result: Result = Producto.GetById(IdProducto)
            if result.Correct!{
                
                let producto = result.Object as! Producto
                
                NombreInput.text = producto.Nombre
                PrecioUnitarioInput.text = String(producto.PrecioUnitario!)
                StockInput.text = String(producto.Stock!)
                
                // Propiedad siendo asignada de a dropdown
                ProveedorDropDown.text = producto.proveedor.Nombre!
                DepartamentoDropDown.text = producto.departamento.Nombre!
                
                DescripcionInput.text = producto.Descripcion!
                
                ActionButton.setTitle("Actualizar", for: .normal)
                ActionButton.backgroundColor = .yellow
                
            }else{
                ActionButton.setTitle("Agregar", for: .normal)
                ActionButton.backgroundColor = .green
            }
        }
    }
    
    
    func LoadDataProveedor(){
        result = try! Proveedor.GetAll()
        if result.Correct!{
            proveedores = result.Objects as! [Proveedor]
            for proveedor in proveedores {

                arrayProveedor.append(proveedor.Nombre!)
                arrayIdProveedor.append(proveedor.IdProveerdor!)
            }
        }
    }
    
    func LoadDataDepartamento(){
        result = try! Departamento.GetAll()
        if result.Correct!{
            departamentos = result.Objects as! [Departamento]
            for departamento in departamentos {
                
                arrayDepartamento.append(departamento.Nombre!)
                arrayIdDepartamento.append(departamento.IdDepartamento!)
                
            }
        }
    }
    
    
}
