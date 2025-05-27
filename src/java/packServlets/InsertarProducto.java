package packServlets;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import packDB.ConexionDB;

public class InsertarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String nombre = request.getParameter("nombreProductoInsertar");
        String precioS = request.getParameter("precioProductoInsertar");
        String stockS = request.getParameter("stockProductoInsertar");
        String codigoBarras = request.getParameter("codigoBarrasInsertar");
        String estadoProceso = "";
        String urlEnvio = "";

        if (nombre == null || nombre.trim().isEmpty()
                || precioS == null || precioS.trim().isEmpty()
                || stockS == null || stockS.trim().isEmpty()) {
            estadoProceso = "Los datos no pueden ser nulos o vacios.";
            session.setAttribute("estadoProceso", estadoProceso);
            urlEnvio = "productos.jsp";

        } else {
            try {
                double precio = Double.parseDouble(precioS);
                int stock = Integer.parseInt(stockS);

                if (precio < 0 || stock < 0) {
                    estadoProceso = "El precio y el stock no pueden ser negativos.";
                    session.setAttribute("estadoProceso", estadoProceso);
                    urlEnvio = "productos.jsp";

                } else {
                    Connection conn = ConexionDB.getConexion();
                    if (conn == null) {
                        response.sendRedirect("errorConexion.jsp");
                        return;
                    }
                    try {
                        String queryCheck;
                        PreparedStatement ps;

                        if (codigoBarras == null || codigoBarras.trim().isEmpty()) {
                            queryCheck = "SELECT COUNT(*) FROM productos WHERE nombre = ?";
                            ps = conn.prepareStatement(queryCheck);
                            ps.setString(1, nombre);
                        } else {
                            queryCheck = "SELECT COUNT(*) FROM productos WHERE nombre = ? OR codigo_barras = ?";
                            ps = conn.prepareStatement(queryCheck);
                            ps.setString(1, nombre);
                            ps.setString(2, codigoBarras);
                        }
                        ResultSet rs = ps.executeQuery();

                        if (rs.next() && rs.getInt(1) > 0) {
                            estadoProceso = "El producto ya existe en la base de datos.";
                            session.setAttribute("estadoProceso", estadoProceso);
                            urlEnvio = "productos.jsp";
                        } else {
                            // No existe, entonces insertar
                            String insertQuery = "INSERT INTO productos (nombre, precio, stock, codigo_barras) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                                insertStmt.setString(1, nombre);
                                insertStmt.setDouble(2, precio);
                                insertStmt.setInt(3, stock);
                                insertStmt.setString(4, codigoBarras);

                                if (insertStmt.executeUpdate() > 0) {
                                    estadoProceso = "Producto añadido con éxito";
                                } else {
                                    estadoProceso = "El producto no ha podido ser añadido.";
                                }
                                session.setAttribute("estadoProceso", estadoProceso);
                                urlEnvio = "productos.jsp";
                            } catch (SQLException e) {
                                e.printStackTrace();
                                estadoProceso = "Error al insertar el producto.";
                                session.setAttribute("estadoProceso", estadoProceso);
                                urlEnvio = "productos.jsp";

                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        estadoProceso = "Error al insertar el producto.";
                        session.setAttribute("estadoProceso", estadoProceso);
                        urlEnvio = "productos.jsp";
                    }
                }

            } catch (NumberFormatException e) {
                estadoProceso = "El precio y el stock deben ser valores numéricos válidos.";
                session.setAttribute("estadoProceso", estadoProceso);
                urlEnvio = "productos.jsp";
            }
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
