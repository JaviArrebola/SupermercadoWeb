/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package packDB;

import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

        private static Connection conn;

        public static Connection getConexion() {
            if (conn == null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermercadodb?serverTimezone=UTC&allowMultiQueries=true", "root", "root");
                    System.out.println("Se ha conectado.");
                } catch (ClassNotFoundException ex1) {
                    System.out.println("No se ha conectado: " + ex1);
                } catch (SQLException ex2) {
                    System.out.println("No se ha conectado: " + ex2);
                }
            }
            return conn;
        }
    }

