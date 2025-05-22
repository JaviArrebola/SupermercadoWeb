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
public class InicioSesion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String usuario = request.getParameter("nombre");
        String password = request.getParameter("password");
        
        String queryInicioSesion = "SELECT e.password, e.username FROM administrador a JOIN empleados e ON a.id = e.id WHERE username = ?";
        
        String error = null;
        String enviarPagina = null;
    
        Connection conn = ConexionDB.getConexion();
        String encoded="";
		try {
			encoded = SHA256.generateSHA(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
        ResultSet rs = null;
        try(PreparedStatement ps = conn.prepareStatement(queryInicioSesion)) {
            ps.setString(1,usuario);
            rs = ps.executeQuery();
            if(rs.next()){
                if(encoded.equals(rs.getString("e.password"))){
                    session.setAttribute("usuario", usuario);
                    enviarPagina = "productos.jsp";
                }
                else{
                    error = "Contraseña incorrecta";
                    session.setAttribute("error", error);
                    enviarPagina = "index.jsp";
                    
                }
                
            } else{
                error = "Usuario incorrecto";
                session.setAttribute("error", error);
                enviarPagina = "index.jsp";  
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
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
