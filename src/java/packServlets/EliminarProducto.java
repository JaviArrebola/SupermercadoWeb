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
 * Servlet encargado de eliminar un producto de la base de datos.
 */
public class EliminarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Se obtiene el ID del producto desde los parámetros del formulario
        String idProducto = request.getParameter("idProducto");

        String estadoProceso;// Variable para almacenar el resultado del proceso
        String urlEnvio = "productos.jsp";// Página a la que se redirige tras la operación

        // Validar que el ID no sea nulo o vacío
        if (idProducto != null && !idProducto.isEmpty()) {
            int productoId = Integer.parseInt(idProducto);

            Connection conn = ConexionDB.getConexion();
            if (conn == null) {
                // Si la conexión falla, redirigir a una página de error
                response.sendRedirect("errorConexion.jsp");
                return;
            }

            try {
                // Verificar si el producto está en detalle_venta
                boolean estaEnUso = false;
                try (PreparedStatement psCheck = conn.prepareStatement(
                        "SELECT 1 FROM detalle_venta WHERE id_producto = ? LIMIT 1")) {
                    psCheck.setInt(1, productoId);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) {
                            estaEnUso = true;
                        }
                    }
                }

                if (estaEnUso) {
                    // No se permite eliminar el producto si está asociado a alguna venta
                    estadoProceso = "No se puede eliminar el producto porque está asociado a una venta.";
                } else {
                    // Intentar eliminar el producto si no está en uso
                    try (PreparedStatement psDelete = conn.prepareStatement(
                            "DELETE FROM productos WHERE id = ?")) {
                        psDelete.setInt(1, productoId);
                        int filas = psDelete.executeUpdate();

                        // Verificar si se eliminó correctamente
                        if (filas > 0) {
                            estadoProceso = "Producto eliminado con éxito.";
                        } else {
                            estadoProceso = "No se pudo eliminar el producto.";
                        }
                    }
                }

            } catch (SQLException e) {
                // Capturar errores relacionados con la base de datos
                e.printStackTrace();
                estadoProceso = "Error en la base de datos al eliminar el producto.";
            }

        } else {
            // Si el ID es inválido
            estadoProceso = "ID de producto inválido.";
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
