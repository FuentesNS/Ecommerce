//
//  ProductoController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import UIKit
import VisionKit

class ProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    var IdProducto : Int = 0
    @IBOutlet weak var NombreInput: UITextField!
    @IBOutlet weak var PrecioUnitarioInput: UITextField!
    @IBOutlet weak var StockInput: UITextField!
    @IBOutlet weak var IdProveedorInput: UITextField!
    @IBOutlet weak var IdDepartamentoInput: UITextField!
    @IBOutlet weak var DescripcionInput: UITextField!
    
    @IBOutlet weak var ActionButton: UIButton!
    
    @IBOutlet weak var PhotoProducto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validate()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func GetPhoto() {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        } else{
            // ERROR Camara
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
        producto.proveedor.IdProveerdor = Int(IdProveedorInput.text!)
        producto.departamento.IdDepartamento = Int(IdDepartamentoInput.text!)
        producto.Descripcion = DescripcionInput.text
        
        
        //let textButton = sender.currentTitle
        
        if sender.titleLabel?.text == "Agregar"{
            // function add product
            Producto.Add(producto)
            
            print("Apartado de agregar producto")
            
        }else if sender.titleLabel?.text == "Actualizar"{
            Producto.Update(producto) 
        }
        
    }
 
    func Validate(){
        if IdProducto != 0{
            let result: Result = Producto.GetById(IdProducto: IdProducto)
            if result.Correct!{
                
                let producto = result.Object as! Producto
                
                NombreInput.text = producto.Nombre
                PrecioUnitarioInput.text = String(producto.PrecioUnitario!)
                StockInput.text
                = String(producto.Stock!)
                IdProveedorInput.text = String(producto.proveedor.IdProveerdor!)
                IdDepartamentoInput.text = String(producto.departamento.IdDepartamento!)
                
                DescripcionInput.text = producto.Descripcion
                
                ActionButton.setTitle("Actualizar", for: .normal)
                ActionButton.backgroundColor = .yellow
                
            }else{
                ActionButton.setTitle("Agregar", for: .normal)
                ActionButton.backgroundColor = .green
            }
        }
    }
    
    
}
