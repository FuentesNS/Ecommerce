//
//  Producto.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import Foundation
import SQLite3

class Producto{
    var IdProducto : Int?
    var Nombre: String?
    var PrecioUnitario: Int?
    var Stock: Int?
    
    var proveedor = Proveedor()
    var departamento = Departamento()
    
    var Descripcion: String?
    var Imagen: String?
    
    
    static func Add(_ producto: Producto) ->Result{
        let result = Result()
        
        let query = "INSERT INTO Producto(Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento, Descripcion) VALUES (?,?,?,?,?,?);"
        
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if(sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil)) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_int(statement, 2, Int32(producto.PrecioUnitario! as NSInteger))
                
                sqlite3_bind_int(statement, 3, Int32(producto.Stock! as NSInteger))
                
                sqlite3_bind_int(statement, 4, Int32(producto.proveedor.IdProveerdor! as NSInteger))
                
                sqlite3_bind_int(statement, 5, Int32(producto.departamento.IdDepartamento! as NSInteger))
                
                sqlite3_bind_text(statement, 6, (producto.Descripcion! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    
                    print("Producto agregado correctamente")
                }else{
                    result.Correct = false
                    
                    print("Ocurrio un error al agregar el Producto")
                }
            } else {
                print("Ocurrion un fallo")
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    
    static func Update(_ producto: Producto) ->Result{
        var result = Result()
        
        return result
    }
    
    
    static func Delete(_ IdProducto: Int)-> Result{
        var result = Result()

        let query = "DELETE FROM Producto WHERE IdProducto = \(IdProducto);"
        
        var statemnt: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statemnt, nil) == SQLITE_OK{
                
                if sqlite3_step(statemnt) == SQLITE_DONE{
                    print("Producto eliminado Correctamente")
                }else{
                    print("Ocurrio un erro al eliminar el Producto")
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    
    static func GetAll()-> Result{
        let result = Result()
        
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento, Descripcion FROM Producto"
        
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = [Any]()
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    let producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement!, 1))
                    producto.PrecioUnitario = Int(sqlite3_column_int(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.proveedor.IdProveerdor = Int(sqlite3_column_int(statement, 4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }else{
                result.Correct = false
                result.ErrorMessage = "Nose encontro informacion de  producto"
            }
            
        } catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    static func GetById(IdProducto: Int) -> Result{
        let result = Result()
        
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento, Descripcion FROM Producto WHERE IdProducto = \(IdProducto);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                if sqlite3_step(statement) == SQLITE_ROW{
                    
                    let producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement!, 1))
                    producto.PrecioUnitario = Int(sqlite3_column_int(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.proveedor.IdProveerdor = Int(sqlite3_column_int(statement, 4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Object = producto
                }
                result.Correct = true
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
}
