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
    var Imagen: String? = ""
    
    
    static func Add(_ producto: Producto) ->Result{
        let result = Result()
        
        let query = "INSERT INTO Producto(Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento, Descripcion, Imagen) VALUES (?,?,?,?,?,?,?);"
        
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if(sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil)) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_int(statement, 2, Int32(producto.PrecioUnitario! as NSInteger))
                
                sqlite3_bind_int(statement, 3, Int32(producto.Stock! as NSInteger))
                
                sqlite3_bind_int(statement, 4, Int32(producto.proveedor.IdProveedor! as NSInteger))
                
                sqlite3_bind_int(statement, 5, Int32(producto.departamento.IdDepartamento! as NSInteger))
                
                sqlite3_bind_text(statement, 6, (producto.Descripcion! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_text(statement, 7, (producto.Imagen! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Producto agregado correctamente")
                }else{
                    result.Correct = false
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
                }
            } else {
                result.Correct = false
                print("Ocurrion un fallo ")
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
    
    
    
    
    static func Update(_ producto: Producto) ->Result{
        var result = Result()
        
         let query = "UPDATE Producto SET  Nombre= ?, PrecioUnitario= ?, Stock= ?, IdProveedor= ?, IdDepartamento= ?, Descripcion= ?  WHERE IdProducto = \(producto.IdProducto!)"
        
        var statement: OpaquePointer?
        let conexion = Conexion.init()
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_int(statement, 2, Int32(producto.PrecioUnitario! as NSInteger))
                
                sqlite3_bind_int(statement, 3, Int32(producto.Stock! as NSInteger))
                
                sqlite3_bind_int(statement, 4, Int32(producto.proveedor.IdProveedor! as NSInteger))
                
                sqlite3_bind_int(statement, 5, Int32(producto.departamento.IdDepartamento! as NSInteger))
                
                sqlite3_bind_text(statement, 6, (producto.Descripcion! as NSString).utf8String, -1, nil)
                
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Producto Actualizado Correctamente")
                }else{
                    result.Correct = false
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
                }
            }else{
                result.Correct = false
                print("Ocurrio un error al Actualizar el Producto")
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
    
    
    
    
    static func Delete(_ IdProducto: Int)-> Result{
        var result = Result()

        let query = "DELETE FROM Producto WHERE IdProducto = \(IdProducto);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                if sqlite3_step(statement) == SQLITE_DONE{
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
        sqlite3_finalize(statement)
        sqlite3_close(conexion.db)
        return result
    }
    
    
    static func GetAll()-> Result{
        let result = Result()
        
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento, Descripcion, Imagen FROM Producto"
        
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
                    producto.proveedor.IdProveedor = Int(sqlite3_column_int(statement, 4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 6))
                    
                    if sqlite3_column_text(statement, 7) != nil{
                        producto.Imagen! = String(cString: sqlite3_column_text(statement, 7))
                    }
                    
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
        sqlite3_finalize(statement)
        sqlite3_close(conexion.db)
        return result
    }
    
    static func GetById(_ IdProducto: Int) -> Result{
        let result = Result()
        
        let query = "SELECT  Producto.IdProducto, Producto.Nombre, Producto.PrecioUnitario, Producto.Stock,Proveedor.IdProveedor, Proveedor.Nombre,Departamento.IdDepartamento, Departamento.Nombre, Producto.Descripcion FROM Producto INNER JOIN Departamento ON (Producto.IdDepartamento = Departamento.IdDepartamento) INNER JOIN Proveedor ON (Producto.IdProveedor = Proveedor.IdProveedor) WHERE Producto.IdProducto =  \(IdProducto);"
        
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
                    
                    producto.proveedor.IdProveedor = Int(sqlite3_column_int(statement, 4))
                    producto.proveedor.Nombre = String(cString: sqlite3_column_text(statement!, 5))

                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    producto.departamento.Nombre = String(cString: sqlite3_column_text(statement!, 7))

                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 8))
                    
                    result.Object = producto
                }
                result.Correct = true
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
    
    
    
    static func GetByIdDepartamento(_ IdDepartamento: Int) -> Result{
        let result = Result()
        
        let query = "SELECT  Producto.IdProducto, Producto.Nombre, Producto.PrecioUnitario, Producto.Stock, Proveedor.IdProveedor, Proveedor.Nombre, Departamento.IdDepartamento, Departamento.Nombre, Area.IdArea, Area.Nombre, Producto.Descripcion FROM Producto INNER JOIN Departamento ON (Producto.IdDepartamento = Departamento.IdDepartamento) INNER JOIN Proveedor ON (Producto.IdProveedor = Proveedor.IdProveedor)INNER JOIN Area ON (Departamento.IdArea = Area.IdArea) WHERE Producto.IdDepartamento =  \(IdDepartamento);"
        
        var statement: OpaquePointer? = nil
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
                    
                    producto.proveedor.IdProveedor = Int(sqlite3_column_int(statement, 4))
                    producto.proveedor.Nombre = String(cString: sqlite3_column_text(statement!, 5))

                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    producto.departamento.Nombre = String(cString: sqlite3_column_text(statement!, 7))

                    producto.departamento.area.IdArea = Int(sqlite3_column_int(statement, 8))
                    producto.departamento.area.Nombre = String(cString: sqlite3_column_text(statement!, 9))
                    
                    producto.Descripcion = String(cString: sqlite3_column_text(statement!, 10))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
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
