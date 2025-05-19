package packServlets;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import packDB.ConexionDB;

public class EliminarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String idProducto = request.getParameter("idProducto");
        String estado;
        String urlEnvio = null;
        
        if(idProducto != null && !idProducto.isEmpty()){
            int producto = Integer.parseInt(idProducto);
            Connection conn = ConexionDB.getConexion();
            ResultSet rs = null;
            try(PreparedStatement ps = conn.prepareStatement("SELECT * FROM productos WHERE id = ?")) {
                ps.setInt(1, producto);
                
                rs = ps.executeQuery();

                if(rs.next()){
                    try(PreparedStatement ps1 = conn.prepareStatement("DELETE FROM productos WHERE id = ?")) {
                        ps1.setInt(1, producto);
                        
                        if(ps1.executeUpdate() > 0){
                            estado = "Producto eliminado con exito."; 
                            session.setAttribute("estado", estado);
                            urlEnvio = "productos.jsp";
                        } else{
                            estado = "No se ha podido eliminar el producto.";
                            session.setAttribute("estado", estado);
                            urlEnvio = "productos.jsp";
                        }
                        
                    } catch (SQLException e) {
                        e.printStackTrace();

                    }
                } else {
                    estado = "El producto no estaba en la lista.";
                    session.setAttribute("estado", estado);
                    urlEnvio = "productos.jsp";
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else{
            estado = "No se ha podido eliminar el producto.";
            session.setAttribute("estado", estado);
            urlEnvio = "productos.jsp";
            
        }
        response.sendRedirect(urlEnvio);
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
