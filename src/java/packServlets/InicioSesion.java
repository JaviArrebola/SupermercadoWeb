package packServlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import packClass.SHA256;
import packDB.ConexionDB;

/**
 * Servlet que gestiona el inicio de sesión de un usuario administrador.
 */
public class InicioSesion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Recupera los parámetros enviados por el formulario de inicio de sesión
        String usuario = request.getParameter("nombre");
        String password = request.getParameter("password");

        // Consulta SQL para obtener la contraseña y nombre de usuario del empleado administrador
        String queryInicioSesion = "SELECT e.password, e.username FROM administrador a JOIN empleados e ON a.id = e.id WHERE username = ?";

        String error = null; // Variable para almacenar posibles mensajes de error
        String enviarPagina = null; // Página a la que se redirige tras la validación

        Connection conn = ConexionDB.getConexion();
        if (conn == null) {
            // Si no hay conexión, se redirige a una página de error
            response.sendRedirect("errorConexion.jsp");
            return;
        }

        // Se encripta la contraseña ingresada usando SHA256
        String codificado = "";
        try {
            codificado = SHA256.generateSHA(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        ResultSet rs = null;
        try (PreparedStatement ps = conn.prepareStatement(queryInicioSesion)) {
            ps.setString(1, usuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Si se encontró el usuario, se compara la contraseña encriptada
                if (codificado.equals(rs.getString("e.password"))) {
                    // Contraseña correcta: se guarda el usuario en sesión y se redirige a productos.jsp
                    session.setAttribute("usuario", usuario);
                    enviarPagina = "productos.jsp";
                } else {
                    // Contraseña incorrecta: mensaje de error y redirección a index.jsp
                    error = "Contraseña incorrecta";
                    session.setAttribute("error", error);
                    enviarPagina = "index.jsp";
                }

            } else {
                // Usuario no encontrado: mensaje de error y redirección a index.jsp
                error = "Usuario incorrecto";
                session.setAttribute("error", error);
                enviarPagina = "index.jsp";
            }

        } catch (SQLException e) {
            // Manejo de excepciones de base de datos
            e.printStackTrace();
        } finally {
            // Cierre seguro del ResultSet para liberar recursos
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(enviarPagina);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
