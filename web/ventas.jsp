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
                                <li class="nav-item"><a class="nav-link" href="StockProductos.jsp">Stock productos</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="CerrarSesion">Cerrar Sesión</a></li>
                </ul>
            </div>
            <div class="flex-grow-1 p-4 content-area">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Ventas</h2>
                    <div class="d-flex align-items-center gap-3">
                        <label for="ordenarTablaVenta">Ordenar por:</label>
                        <select id="ordenarTablaVenta">
                            <option value="idv-asc">ID Ascendente</option>
                            <option value="idv-desc">ID Descendente</option>
                            <option value="fechav-asc">Fecha Ascendente</option>
                            <option value="fechav-desc">Fecha Descendente</option>
                            <option value="totalv-asc">Total Ascendente</option>
                            <option value="totalv-desc">Total Descendente</option>
                        </select>

                    </div>
                </div>
                <div class="table-responsive" id="tablaVentas">
                    <table class="table-custom">
                        <thead >
                            <tr>
                                <th>ID Venta</th>
                                <th>Fecha</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection conn = ConexionDB.getConexion();
                                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM ventas");
                                     ResultSet rs = ps.executeQuery()) {
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("id_venta") %></td>
                                <td><%= rs.getString("fecha") %></td>
                                <td><%= rs.getString("total") %></td>
                            </tr>
                            <%
                                    }
                                } catch (SQLException e) {
                                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="venta.js"></script>
    </body>
</html>
