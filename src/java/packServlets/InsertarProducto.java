package packServlets;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import packDB.ConexionDB;

/**
 * Servlet que gestiona la inserción de nuevos productos en la base de datos.
 */
public class InsertarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombreProductoInsertar");
        String precioS = request.getParameter("precioProductoInsertar");
        String stockS = request.getParameter("stockProductoInsertar");
        String codigoBarras = request.getParameter("codigoBarrasInsertar");

        String estadoProceso = ""; // Mensaje del estado del proceso
        String urlEnvio = "productos.jsp"; // Página a la que se redirigirá

        // Validación básica de campos vacíos o nulos
        if (nombre == null || nombre.trim().isEmpty()
                || precioS == null || precioS.trim().isEmpty()
                || stockS == null || stockS.trim().isEmpty()) {

            estadoProceso = "Los datos no pueden ser nulos o vacíos.";
            session.setAttribute("estadoProceso", estadoProceso);
            response.sendRedirect(urlEnvio);
            return;
        }
        try {
            // Conversión de valores numéricos
            double precio = Double.parseDouble(precioS);
            int stock = Integer.parseInt(stockS);

            if (precio < 0 || stock < 0) {
                estadoProceso = "El precio y el stock no pueden ser negativos.";
                session.setAttribute("estadoProceso", estadoProceso);
                response.sendRedirect(urlEnvio);
                return;
            }

            Connection conn = ConexionDB.getConexion();
            if (conn == null) {
                response.sendRedirect("errorConexion.jsp");
                return;
            }

            try {
                // Verificación de existencia del producto (por nombre y opcionalmente código de barras)
                String queryComprobar;
                PreparedStatement ps;

                if (codigoBarras == null || codigoBarras.trim().isEmpty()) {
                    queryComprobar = "SELECT COUNT(*) FROM productos WHERE nombre = ?";
                    ps = conn.prepareStatement(queryComprobar);
                    ps.setString(1, nombre);
                } else {
                    queryComprobar = "SELECT COUNT(*) FROM productos WHERE nombre = ? OR codigo_barras = ?";
                    ps = conn.prepareStatement(queryComprobar);
                    ps.setString(1, nombre);
                    ps.setString(2, codigoBarras);
                }
                ResultSet rs = ps.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    // Ya existe un producto con ese nombre o código de barras
                    estadoProceso = "El producto ya existe en la base de datos.";
                } else {
                    // Inserción del nuevo producto
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
                    } catch (SQLException e) {
                        e.printStackTrace();
                        estadoProceso = "Error al insertar el producto.";

                    }
                }

                // Cierre de recursos
                ps.close();
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
                estadoProceso = "Error al insertar el producto.";
            }

        } catch (NumberFormatException e) {
            // Captura de errores al parsear valores numéricos
            estadoProceso = "El precio y el stock deben ser valores numéricos válidos.";
        }
        session.setAttribute("estadoProceso", estadoProceso);
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
