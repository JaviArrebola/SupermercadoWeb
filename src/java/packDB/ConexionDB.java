package packDB;

import java.sql.*;

/**
 * Clase para gestionar la conexión a la base de datos MySQL. Implementa un
 * patrón Singleton para reutilizar la misma conexión.
 */
public class ConexionDB {

    // Variable estática que mantiene una única instancia de la conexión
    private static Connection conn;

    /**
     * Método para obtener una conexión a la base de datos. Si la conexión aún
     * no ha sido establecida, se crea y se reutiliza posteriormente.
     *
     * @return Una instancia de java.sql.Connection conectada a la base de
     * datos.
     */
    public static Connection getConexion() {
        // Si la conexión no ha sido creada aún
        if (conn == null) {
            try {
                // Carga el driver de MySQL 
                Class.forName("com.mysql.jdbc.Driver");

                // Establece la conexión a la base de datos con URL, usuario y contraseña
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermercadodb?serverTimezone=UTC&allowMultiQueries=true", "root", "root");

                // Mensaje en consola para confirmar la conexión exitosa
                System.out.println("Se ha conectado.");
            } catch (ClassNotFoundException ex1) {
                // Manejo del error si el driver no se encuentra
                System.out.println("No se ha conectado: " + ex1);
            } catch (SQLException ex2) {
                // Manejo de errores al intentar conectarse a la base de datos
                System.out.println("No se ha conectado: " + ex2);
            }
        }
        // Devuelve la conexión (nueva o previamente creada)
        return conn;
    }
}
