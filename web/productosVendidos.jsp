<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packDB.ConexionDB"%>
<%@page import="java.sql.*"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link href="style.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="imagenes/icon.png">

    </head>
    <body>
        <nav class="navbar px-3 custom-navbar">
            <div class="d-flex align-items-center">
                <img src="imagenes/icon.png" alt="Supermercado" width="40" class="me-2" />
                <span class="navbar-brand mb-0 h1">Supermercado</span>
            </div>
        </nav>

        <div class="main-wrapper">
            <div class="sidebar p-3">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#submenu" role="button" aria-expanded="false" aria-controls="submenu">
                            Estadísticas <i class="fa-solid fa-arrow-down"></i>
                        </a>
                        <div class="collapse ps-3" id="submenu">
                            <ul class="nav flex-column">
                                <li class="nav-item"><a class="nav-link" href="ventas.jsp">Ventas</a></li>
                                <li class="nav-item"><a class="nav-link" href="productosVendidos.jsp">Productos vendidos</a></li>
                                <li class="nav-item"><a class="nav-link" href="stockProductos.jsp">Stock productos</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="CerrarSesion">Cerrar Sesión</a></li>
                </ul>
            </div>
            <div class="flex-grow-1 p-4 content-area">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Productos Vendidos</h2>
                    <div class="d-flex align-items-center gap-3">
                        <label for="ordenar">Ordenar por:</label>
                        <select id="ordenarTablaVendidos">
                            <option value="0-asc">ID Venta Ascendente</option>
                            <option value="0-desc">ID Venta Descendente</option>
                            <option value="1-asc">ID Producto Ascendente</option>
                            <option value="1-desc">ID Producto Descendente</option>
                            <option value="2-asc">Nombre Ascendente</option>
                            <option value="2-desc">Nombre Descendente</option>
                            <option value="3-asc">Cantidad Ascendente</option>
                            <option value="3-desc">Cantidad Descendente</option>
                            <option value="4-asc">Precio Ascendente</option>
                            <option value="4-desc">Precio Descendente</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table-custom" id="tablaVendidos">
                        <thead >
                            <tr>
                                <th>ID Venta</th>
                                <th>ID Producto</th>
                                <th>Nombre</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection conn = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                try {
                                    conn = ConexionDB.getConexion();
                                    String sql = "SELECT dv.id_venta, dv.id_producto, p.nombre AS nombre_producto, " +
                                                 "SUM(dv.cantidad) AS cantidad, " +
                                                 "SUM(dv.cantidad * dv.precio_unitario) AS precio_total " +
                                                 "FROM detalle_venta dv " +
                                                 "JOIN productos p ON dv.id_producto = p.id " +
                                                 "GROUP BY dv.id_venta, dv.id_producto, p.nombre " +
                                                 "ORDER BY dv.id_venta, dv.id_producto";

                                    ps = conn.prepareStatement(sql);
                                    rs = ps.executeQuery();

                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("id_venta") %></td>
                                <td><%= rs.getInt("id_producto") %></td>
                                <td><%= rs.getString("nombre_producto") %></td>
                                <td><%= rs.getInt("cantidad") %></td>
                                <td><%= rs.getBigDecimal("precio_total") %></td>
                            </tr>
                            <%
                                 }
                                } catch (SQLException e) {
                                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>
        <script src="script.js"></script>
    </body>
</html>