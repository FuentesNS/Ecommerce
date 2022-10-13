//
//  Usuario.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 20/09/22.
//

import Foundation
import SQLite3

class Usuario{
    var IdUsuario: Int? = nil
    var UserName: String? = nil
    var Nombre: String? = nil
    var ApellidoPaterno: String? = nil
    var ApellidoMaterno: String? = nil
    var Email : String? = nil
    var Password: String? = nil
    var Confirmacion: String? = nil
    
    
    static func Add(_ usuario: Usuario) -> Result{
        
        let result = Result()
        
        let query = "INSERT INTO Usuario(UserName, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Password) VALUES(?,?,?,?,?,?);"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (usuario.UserName! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (usuario.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 4, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (usuario.Email! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 6, (usuario.Password! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Usuario agregado correctamente")
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("Ocurrion un fallo \(errmsg)")
                }
            }else{
                print("Ocurrio un error")
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
    
    
    
    static func Update(_ usuario: Usuario) -> Result{
        
        let result = Result()
        
        let query = #"UPDATE Usuario SET UserName= '?', Nombre= ?, ApellidoPaterno= ?, ApellidoMaterno= ?, Email= ?, Password= ?  WHERE IdUsuario = \#(usuario.IdUsuario!)"#
        
        var statement: OpaquePointer?
        let conexion = Conexion.init()
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                //sqlite3_bind_int(statement, 1, (usuario.IdUsuario as NSInteger). )
                sqlite3_bind_text(statement, 1, (usuario.UserName! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (usuario.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 4, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (usuario.Email! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 6, (usuario.Password! as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Usuario Actualizado Correctamente")
                }else{
                    print("Ocurrio un error al Actualizar el Usuario")
                }
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
    
    
    
    static func Delete(idUsuario: Int) -> Result{
        
        let result = Result()
        
        let query = "DELETE FROM Usuario WHERE IdUsuario = \(idUsuario)"
        
        var statement: OpaquePointer?
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Usuario elimando Correctamente")
                }else{
                    print("Ocurrio un error al intentar eliminar el Usuario")
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
        
        let query = "SELECT IdUsuario, UserName, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Password FROM Usuario"
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = [Any]()
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    let usuario = Usuario()
                    
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.UserName = String(cString: sqlite3_column_text(statement, 1))
                    usuario.Nombre = String(cString: sqlite3_column_text(statement, 2))
                    usuario.ApellidoPaterno = String(cString: sqlite3_column_text(statement, 3))
                    usuario.ApellidoMaterno = String(cString: sqlite3_column_text(statement, 4))
                    usuario.Email = String(cString: sqlite3_column_text(statement, 5))
                    usuario.Password = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Objects?.append(usuario)
                }
                result.Correct = true
            }else{
                result.Correct = false
                result.ErrorMessage = "No se encontro informacion"
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
    
    
    static func GetById(idUsuario: Int) -> Result{
        let result = Result()
        
        let query = "SELECT IdUsuario, UserName, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Password FROM Usuario WHERE IdUsuario = \(idUsuario);"
        
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                if sqlite3_step(statement) == SQLITE_ROW{
                    
                    let usuario = Usuario()
                    
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.UserName = String(cString: sqlite3_column_text(statement, 1))
                    usuario.Nombre = String(cString: sqlite3_column_text(statement, 2))
                    usuario.ApellidoPaterno = String(cString: sqlite3_column_text(statement, 3))
                    usuario.ApellidoMaterno = String(cString: sqlite3_column_text(statement, 4))
                    usuario.Email = String(cString: sqlite3_column_text(statement, 5))
                    usuario.Password = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Object = usuario
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
    
    
    
    static func GetByEmail(_ Email: String) -> Result{
        let result = Result()
        
        let query = #"SELECT IdUsuario, UserName, Nombre, ApellidoPaterno, ApellidoMaterno, Email, Password FROM Usuario WHERE Email = '\#(Email)';"#
        
        
        var statement: OpaquePointer? = nil
        let conexion = Conexion.init()
        
        do{
            if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                
                if sqlite3_step(statement) == SQLITE_ROW{
                    
                    let usuario = Usuario()
                    
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.UserName = String(cString: sqlite3_column_text(statement, 1))
                    usuario.Nombre = String(cString: sqlite3_column_text(statement, 2))
                    usuario.ApellidoPaterno = String(cString: sqlite3_column_text(statement, 3))
                    usuario.ApellidoMaterno = String(cString: sqlite3_column_text(statement, 4))
                    usuario.Email = String(cString: sqlite3_column_text(statement, 5))
                    usuario.Password = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Correct = true

                    result.Object = usuario
                } else{
                    result.Correct = false
                }
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



