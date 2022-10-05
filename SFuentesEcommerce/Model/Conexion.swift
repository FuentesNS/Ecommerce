//
//  Conexion.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 21/09/22.
//

import Foundation
import SQLite3

class Conexion {
    var db: OpaquePointer?
    var path: String = "Documnet.SFuentesEcommerce.sql"
    
    init(){
        self.db = CreateDB()
    }
    
    func CreateDB() -> OpaquePointer?{
        let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("No se creo el archivo")
            return nil
        }else{
            print("La base de datos se creo exitosamente")
            print(filePath)
            return db
        }
    }
}
