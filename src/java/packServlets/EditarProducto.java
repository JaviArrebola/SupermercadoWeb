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
 * Servlet que permite editar un producto existente en la base de datos.
 */
public class EditarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Obtener parámetros del formulario
        String idS = request.getParameter("idProductoEditar");
        String nombre = request.getParameter("nombreProductoEditar");
        String precioS = request.getParameter("precioProductoEditar");
        String stockS = request.getParameter("stockProductoEditar");
        String codigoBarras = request.getParameter("codigoBarrasEditar");
        String estadoProceso = "";
        String urlEnvio = "productos.jsp";

        // Validación básica: que ningún campo obligatorio esté vacío
        if (idS != null && !idS.isEmpty()
                && nombre != null && !nombre.isEmpty()
                && precioS != null && !precioS.isEmpty()
                && stockS != null && !stockS.isEmpty()) {

            // Parsear valores numéricos
            int id = Integer.parseInt(idS);
            double precio = Double.parseDouble(precioS);
            int stock = Integer.parseInt(stockS);

            // Validar que precio y stock sean positivos
            if (precio < 0) {
                estadoProceso = "El precio debe ser un número positivo.";
                session.setAttribute("estadoProceso", estadoProceso);
                response.sendRedirect(urlEnvio);
                return;
            }

            if (stock < 0) {
                estadoProceso = "El stock no puede ser negativo.";
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
                boolean verificarDuplicados = true;
                String nombreActual = null;
                String codigoActual = null;

                // Obtener los valores actuales del producto
                try (PreparedStatement psSelectActual = conn.prepareStatement(
                        "SELECT nombre, codigo_barras FROM productos WHERE id = ?")) {
                    psSelectActual.setInt(1, id);
                    try (ResultSet rsActual = psSelectActual.executeQuery()) {
                        if (rsActual.next()) {
                            nombreActual = rsActual.getString("nombre");
                            codigoActual = rsActual.getString("codigo_barras");

                            // Si nombre y código de barras no han cambiado, no es necesario verificar duplicados
                            if (nombre.equals(nombreActual) && codigoBarras.equals(codigoActual)) {
                                verificarDuplicados = false;
                            }
                        }
                    }
                }

                // Verificar que no exista otro producto con el mismo nombre o código de barras
                if (verificarDuplicados) {
                    try (PreparedStatement psCheckDuplicados = conn.prepareStatement(
                            "SELECT id FROM productos WHERE (nombre = ? OR codigo_barras = ?) AND id <> ?")) {
                        psCheckDuplicados.setString(1, nombre);
                        psCheckDuplicados.setString(2, codigoBarras);
                        psCheckDuplicados.setInt(3, id);
                        try (ResultSet rsCheck = psCheckDuplicados.executeQuery()) {
                            if (rsCheck.next()) {
                                estadoProceso = "Ya existe otro producto con ese nombre o código de barras.";
                                session.setAttribute("estadoProceso", estadoProceso);
                                response.sendRedirect("productos.jsp");
                                return;
                            }
                        }
                    }
                }

                // Actualizar los datos del producto en la base de datos
                try (PreparedStatement psUpdate = conn.prepareStatement(
                        "UPDATE productos SET nombre = ?, precio = ?, stock = ?, codigo_barras = ? WHERE id = ?")) {
                    psUpdate.setString(1, nombre);
                    psUpdate.setDouble(2, precio);
                    psUpdate.setInt(3, stock);
                    psUpdate.setString(4, codigoBarras);
                    psUpdate.setInt(5, id);

                    int filas = psUpdate.executeUpdate();
                    if (filas > 0) {
                        estadoProceso = "Producto editado correctamente.";
                    } else {
                        estadoProceso = "No se pudo editar el producto.";
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
                estadoProceso = "Error al editar el producto en la base de datos.";
            }

        } else {
            // Alguno de los campos está vacío o nulo
            estadoProceso = "No se han podido tratar los datos correctamente.";
        }

        // Guardar estado del proceso y redirigir a productos.jsp
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
