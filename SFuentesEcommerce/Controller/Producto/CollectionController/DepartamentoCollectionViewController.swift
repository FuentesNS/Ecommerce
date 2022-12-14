//
//  DepartamentoCollectionViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 10/10/22.
//

import UIKit

private let reuseIdentifier = "DepartamentoCollectionCell"

class DepartamentoCollectionViewController: UICollectionViewController {
    
    var departamentos: [Departamento] = []
    var result = Result()
    var departamento = Departamento()
    var IdArea : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
        self.collectionView.register(UINib(nibName: "DepartamentoCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    func LoadData(){
        do{
            result = try! Departamento.GetByIdArea(IdArea)
            if result.Correct!{
                departamentos = result.Objects as! [Departamento]
                collectionView.reloadData()
            }
        }catch{
            print("Ocurrio un error")
        }
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DepartamentoCollectionCell
        
        self.departamento = departamentos[indexPath.row]
        
        cell.NombreLabel.text = departamento.Nombre
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        self.departamento = self.departamentos[indexPath.row]
        
        self.performSegue(withIdentifier: "DepartamentoSegues", sender: self)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartamentoSegues"{
            
            var ProductoCollectionViewController = segue.destination as?  ProductoCardCollectionViewController
            ProductoCollectionViewController?.IdDepartamento = self.departamento.IdDepartamento!
            
            
        }
    }


    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
