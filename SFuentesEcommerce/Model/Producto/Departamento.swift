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
    var IdArea: Int?
    var Nombre: String = ""
    
    var area = Area()
    
    
    static func Add(_ departamento: Departamento) -> Result{
        
        let result = Result()
     
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        
        let query = "INSERT INTO Departamento (Nombre, IdArea) VALUES (?,?);"
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2,  Int32(departamento.area.IdArea! as NSInteger))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Departamento agregado correctamente")
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
                }
            }else{
                print("Ocurrio un error al agregar el Departamento")
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(conexion.db)
        return result
    }
    
    
    static func Update(_ departamento: Departamento) -> Result{
            
        let result = Result()
         
            var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
            
            let query = "UPDATE Departamento SET Nombre= '?', IdArea= '?' WHERE IdDepartamento = \(departamento.IdDepartamento!)"
            
            do{
                if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                    
                    sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                    sqlite3_bind_int(statement, 2,  Int32(departamento.area.IdArea! as NSInteger))
                    
                    if sqlite3_step(statement) == SQLITE_DONE{
                        result.Correct = true
                        print("Departamento actualizado correctamente")
                    }else{
                        let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                        print("Ocurrion un fallo \(errmsg)")
                    }
                }else{
                    print("Ocurrio un error al actualizar el Departamento")
                }
                
            }catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            sqlite3_finalize(statement)
            sqlite3_close(conexion.db)
            return result
        }
    
    static func Delete(_ IdDepartamento: Int) -> Result{
        let result = Result()
        
        let query = "DELETE FROM Departamento WHERE IdDepartamento = \(IdDepartamento)"
        
        var statement: OpaquePointer?
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Departamento elimando Correctamente")
                }else{
                    print("Ocurrio un error al intentar eliminar el Departamento")
                }
            }
        } catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(conexion.db)
        return result
    }
    
    
    
    
    
    static func GetAll() -> Result{
        let result = Result()
        
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
    

    static func GetById(_ IdDepartamento: Int)-> Result{
        let result = Result()
        
        let query = "SELECT IdDepartamento, Nombre, IdArea FROM Departamento WHERE IdDepartamento =\(IdDepartamento);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                                
                if sqlite3_step(statement) == SQLITE_ROW{
                    
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    departamento.area.IdArea = Int(sqlite3_column_int(statement, 2))
                    
                    result.Object = departamento
                    
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
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
        sqlite3_finalize(statement)
        sqlite3_close(conexion.db)
        return result
    }
    
    
    
    static func GetByIdArea(_ IdDepartamento: Int) -> Result{
        let result = Result()
        
        let query = "SELECT Departamento.IdDepartamento, Departamento.Nombre, Departamento.IdArea, Area.Nombre FROM Departamento INNER JOIN Area on (Area.IdArea = Departamento.IdArea) WHERE Departamento.IdDepartamento =\(IdDepartamento);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                if sqlite3_step(statement) == SQLITE_ROW{
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    departamento.area.IdArea = Int(sqlite3_column_int(statement, 2))
                    departamento.area.Nombre = String(cString: sqlite3_column_text(statement, 3))
                    
                    
                    result.Object = departamento
                    result.Correct = true
                }
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
