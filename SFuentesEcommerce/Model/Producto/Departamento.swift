//
//  Departamento.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import Foundation
import SQLite3

class Departamento{
    var IdDepartamento: Int?
    var Nombre: String = ""
    
    var area = Area()
    
    static func GetAll() -> Result{
        var result = Result()
        
        let query = "SELECT IdDepartamento, Nombre, IdArea FROM Departamento;"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = [Any]()
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    departamento.area.IdArea = Int(sqlite3_column_int(statement, 2))
                    
                    result.Objects?.append(departamento)
                    
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
    
    
    static func GetByIdArea(_ IdArea: Int) -> Result{
        let result = Result()
        
        let query = " SELECT IdDepartamento, Nombre, IdArea FROM Departamento WHERE IdArea =\(IdArea);"
        
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = [Any]()
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    departamento.area.IdArea = Int(sqlite3_column_int(statement, 2))
                    
                    result.Objects?.append(departamento)
                    
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
