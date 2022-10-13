//
//  AreaCollectionViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 10/10/22.
//

import UIKit

private let reuseIdentifier = "AreaCollectionCell"

class AreaCollectionViewController: UICollectionViewController {

    var areas: [Area] = []
    var area = Area()
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()



        self.collectionView.register(UINib(nibName: "AreaCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    
    func LoadData (){
        do{
            result = try! Area.GetAll()
            if result.Correct!{
                areas = result.Objects as! [Area]
                collectionView.reloadData()
            }
            
        }catch {
            print("Ocurrio un error")
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return areas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AreaCollectionCell
    
        self.area = areas[indexPath.row]
        
        cell.NombreLabel.text = area.Nombre
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
        //print("You selected cell #\(indexPath.item)!")
        self.area = self.areas[indexPath.row]
        
        self.performSegue(withIdentifier: "AreaSegues", sender: self)
    
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreaSegues"{
            
            var DepartamentoViewController = segue.destination as?  DepartamentoCollectionViewController
            DepartamentoViewController?.IdArea = self.area.IdArea!
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
