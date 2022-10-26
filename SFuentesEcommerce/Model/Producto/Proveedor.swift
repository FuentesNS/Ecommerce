//
//  Proveedor.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import Foundation
import SQLite3

class Proveedor{
    var IdProveedor: Int?
    var Nombre: String = ""
    var Telefono: String?
    
    
    
    static func Add(_ proveedor: Proveedor) -> Result{
        
        var result = Result()
     
        var statement : OpaquePointer? = nil
        var conexion = Conexion.init()
        
        let query = "INSERT INTO Proveedor (Nombre, Telefono) VALUES (?,?);"
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (proveedor.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (proveedor.Telefono! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Proveedor agregado correctamente")
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
                }
            }else{
                print("Ocurrio un error al agregar el proveedor")
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
    
    
    static func Update(_ proveedor: Proveedor) -> Result{
            
            var result = Result()
         
            var statement : OpaquePointer? = nil
            var conexion = Conexion.init()
            
            let query = "UPDATE Proveedor SET Nombre= '?', Telefono= '?'  WHERE IdUsuario = \(proveedor.IdProveedor!)"
            
            do{
                if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                    
                    sqlite3_bind_text(statement, 1, (proveedor.Nombre as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 2, (proveedor.Telefono! as NSString).utf8String, -1, nil)
                    
                    if sqlite3_step(statement) == SQLITE_DONE{
                        result.Correct = true
                        print("Proveedor actualizado correctamente")
                    }else{
                        let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                        print("Ocurrion un fallo \(errmsg)")
                    }
                }else{
                    print("Ocurrio un error al actualizar el proveedor")
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
    
    static func Delete(_ IdProveedor: Int) -> Result{
        let result = Result()
        
        let query = "DELETE FROM Proveedor WHERE IdProveedor = \(IdProveedor)"
        
        var statement: OpaquePointer?
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Proveedor elimando Correctamente")
                }else{
                    print("Ocurrio un error al intentar eliminar el Proveedor")
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
        var result = Result()
        
        let query = "SELECT IdProveedor, Nombre, Telefono FROM Proveedor;"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = [Any]()
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    let proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(sqlite3_column_int(statement, 0))
                    proveedor.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    proveedor.Telefono = String(cString: sqlite3_column_text(statement, 2))
                    
                    result.Objects?.append(proveedor)
                    
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
    
    static func GetById(_ IdProveedor: Int)-> Result{
        var result = Result()
        
        let query = "SELECT IdProveedor, Nombre, Telefono FROM Proveedor WHERE IdProveedor =\(IdProveedor);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                                
                if sqlite3_step(statement) == SQLITE_ROW{
                    
                    let proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(sqlite3_column_int(statement, 0))
                    proveedor.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    proveedor.Telefono = String(cString: sqlite3_column_text(statement, 2))
                    
                    result.Object = proveedor
                    
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
    
    
}
