//
//  SQLiteHelper.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/1/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class SQLiteHelper :NSObject {
    
    // sqlite3 *db;
    var db: COpaquePointer = nil;
    
    // Construtor
    init(database: String) {
        super.init()
        
       self.db = open(database)
    }

    // Caminho do banco de dados
    func getFilePath(nome: String) -> String {
        // Caminho com o arquivo
        let path = NSHomeDirectory() + "/Documents/" + nome + ".sqlite3"
        print("Database: \(path)")
        return path
    }
    
    // Abre o banco de dados
    func open(database: String) -> COpaquePointer {
        
        var db: COpaquePointer = nil;
    
        let path = getFilePath(database)
        let cPath = StringUtils.toCString(path)

        let result = sqlite3_open(cPath, &db);
        
        if(result == SQLITE_CANTOPEN) {
            print("Não foi possível abrir o banco de dados SQLite")
            return nil
        }
        
        return db
    }

    // Executa o SQL
    func execSql(sql: String) -> CInt {
        return self.execSql(sql, params: nil)
    }

    func execSql(sql: String, params: Array<AnyObject>!) -> CInt {
        var result:CInt = 0

//        let cSql = StringUtils.toCString(sql)

        // Statement
        let stmt = query(sql, params: params)

        // Step
        result = sqlite3_step(stmt)
        if result != SQLITE_OK && result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            let msg = "Erro ao executar SQL\n\(sql)\nError: \(lastSQLError())"
            print(msg)
            return -1
        }

        // Se for insert recupera o id
        if sql.uppercaseString.hasPrefix("INSERT") {
            // http://www.sqlite.org/c3ref/last_insert_rowid.html
            let rid = sqlite3_last_insert_rowid(self.db)
            result = CInt(rid)
        } else {
            result = 1
        }

        // Fecha o statement
        sqlite3_finalize(stmt)
        
        return result
    }
    
    // Faz o bind dos parametros (?,?,?) de um SQL
    func bindParams(stmt:COpaquePointer, params: Array<AnyObject>!) {
        if(params != nil) {
            let size = params.count
//            println("Bind \(size) values")
            for i:Int in 1...size {
                let value : AnyObject = params[i-1]
                if(value is Int) {
                    let number:CInt = toCInt(value as! Int)
                    
                    sqlite3_bind_int(stmt, toCInt(i), number)
                    
                    // println("bind int \(i) -> \(value)")
                } else {

                    let text: String = value as! String

                    SQLiteObjc.bindText(stmt, idx: toCInt(i), withString: text)

                    //println("bind tetxt \(i) -> \(value)")
                }
            }
        }
    }

    // Executa o SQL e retorna o statement
    func query(sql:String) -> COpaquePointer {
        return query(sql, params: nil)
    }

    // Executa o SQL e retorna o statement
    func query(sql:String, params: Array<AnyObject>!) -> COpaquePointer {
        var stmt:COpaquePointer = nil

        let cSql = StringUtils.toCString(sql)

        // Prepare
        let result = sqlite3_prepare_v2(self.db, cSql, -1, &stmt, nil)

        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            let msg = "Erro ao preparar SQL\n\(sql)\nError: \(lastSQLError())"
            print("SQLite ERROR \(msg)")
        }
        
        // Bind Values (?,?,?)
        if(params != nil) {
            bindParams(stmt, params:params)
        }

        return stmt
    }
    
    // Retorna true se existe a próxima linha da consulta
    func nextRow(stmt:COpaquePointer) -> Bool {
        let result = sqlite3_step(stmt)
        let next: Bool = result == SQLITE_ROW
        return next
    }
    
    // Fecha o banco de dados
    func close() {
        sqlite3_close(self.db)
    }
    
    func closeStatement(stmt:COpaquePointer) {
        // Fecha o statement
        sqlite3_finalize(stmt)
    }
    
    // Retorna o último erro de SQL
    func lastSQLError() -> String {
        var err:UnsafePointer<Int8>? = nil
        err = sqlite3_errmsg(self.db)
        
        if(err != nil) {
            let s = NSString(UTF8String: err!)
            return s! as String
        }
        
        return ""
    }
    
    // Lê uma coluna do tipo Int
    func getInt(stmt:COpaquePointer, index:CInt) -> Int {
        let val = sqlite3_column_int(stmt, index)
        return Int(val)
    }
    
    // Lê uma coluna do tipo Double
    func getDouble(stmt:COpaquePointer, index:CInt) -> Double {
        let val = sqlite3_column_double(stmt, index)
        return Double(val)
    }
    
    // Lê uma coluna do tipo Float
    func getFloat(stmt:COpaquePointer, index:CInt) -> Float {
        let val = sqlite3_column_double(stmt, index)
        return Float(val)
    }
    
    // Lê uma coluna do tipo String
    func getString(stmt:COpaquePointer, index:CInt) -> String {
        
        let cString  = SQLiteObjc.getText(stmt, idx: index)

        let s = String(cString)

        return s
    }
    
    // Converte Int (swift) para CInt(C)
    func toCInt(swiftInt : Int) -> CInt {
        let number : NSNumber = swiftInt as NSNumber
        let pos: CInt = number.intValue
        return pos
    }
}