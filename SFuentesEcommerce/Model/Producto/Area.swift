//
//  Area.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import Foundation
import SQLite3


class Area{
    var IdArea: Int?
    var Nombre: String?
    
    
    static func GetAll() -> Result{
            var result = Result()
            
            let query = "SELECT IdArea, Nombre FROM Area;"
            
            var statement: OpaquePointer? = nil
            let conexion = Conexion.init()
            
            do{
                if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                    
                    result.Objects = [Any]()
                    
                    while sqlite3_step(statement) == SQLITE_ROW{
                        
                        let area = Area()
                        
                        area.IdArea = Int(sqlite3_column_int(statement, 0))
                        area.Nombre = String(cString: sqlite3_column_text(statement, 1))
                        
                        result.Objects?.append(area)
                        
                    }
                    result.Correct = true
                } else{
                    result.Correct = false
                    print("Ocurrio un error al obtenr la informacion")
                }
            }catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            return result
        }
}
