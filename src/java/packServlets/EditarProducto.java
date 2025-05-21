package packServlets;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import packDB.ConexionDB;

public class EditarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String idS = request.getParameter("idProductoEditar");
        String nombre = request.getParameter("nombreProductoEditar");
        String precioS = request.getParameter("precioProductoEditar");
        String stockS = request.getParameter("stockProductoEditar");
        String codigoBarras = request.getParameter("codigoBarrasEditar");
        String estadoEdicion = "";
        String urlEnvio = "";
        System.out.println(idS + nombre + precioS + stockS);
        
        
        if (idS != null && !idS.isEmpty() && nombre != null && !nombre.isEmpty() && precioS != null && !precioS.isEmpty() && stockS != null && !stockS.isEmpty()) {
            int id = Integer.parseInt(idS);
            double precio = Double.parseDouble(precioS);
            int stock = Integer.parseInt(stockS);
            Connection conn = ConexionDB.getConexion();
            try(PreparedStatement ps = conn.prepareStatement("UPDATE productos SET nombre = ?, precio = ?, stock = ?, codigo_barras = ? WHERE id = ?")) {
                ps.setString(1, nombre);
                ps.setDouble(2, precio);
                ps.setInt(3, stock);
                ps.setString(4, codigoBarras);
                ps.setInt(5, id);
                
                if (ps.executeUpdate() > 0){
                    System.out.println("siso1");
                    estadoEdicion = "Producto editado correctamente.";
                    session.setAttribute("estadoEdicion", estadoEdicion);
                    urlEnvio = "productos.jsp";
                }
                else{
                    System.out.println("siso2");
                    estadoEdicion = "El Producto no ha podido ser editado correctamente.";
                    session.setAttribute("estadoEdicion", estadoEdicion);
                    urlEnvio = "productos.jsp";
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
                
        } else{
            System.out.println("siso3");
            estadoEdicion = "No se han podido tratar los datos.";
            session.setAttribute("estadoEdicion", estadoEdicion);
            urlEnvio = "productos.jsp";
            
        }
        System.out.println("siso4");
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
