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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href="style.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="imagenes/icon.png">

    </head>
    <body>
        <nav class="navbar px-3 custom-navbar">
            <div class="d-flex align-items-center">
                <!-- Botón hamburguesa visible solo en móvil -->
                <button class="btn btn-primary d-lg-none me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar">
                    <i class="fa fa-bars"></i>
                </button>
                <img src="imagenes/icon.png" alt="Supermercado" width="40" class="me-2" />
                <span class="navbar-brand mb-0 h1">Supermercado</span>
            </div>
        </nav>


        <div class="d-flex">
            <div class="sidebar p-3 d-none d-lg-block" style="width: 250px; min-height: 100vh; border-right: 1px solid #ddd;">
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
                    <h2 class="mb-0">Stock</h2>
                    <div class="d-flex align-items-center gap-3">
                        <label for="ordenar">Ordenar por:</label>
                        <select id="ordenarTablaStock">
                            <option value="0-asc">ID (Menor a Mayor)</option>
                            <option value="0-desc">ID (Mayor a Menor)</option>
                            <option value="1-asc">Nombre (A-Z)</option>
                            <option value="1-desc">Nombre (Z-A)</option>
                            <option value="2-asc">Stock (Menor a Mayor)</option>
                            <option value="2-desc">Stock (Mayor a Menor)</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table" id="tablaStock">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID Producto</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Stock</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection conn = ConexionDB.getConexion();
                                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM productos");
                                     ResultSet rs = ps.executeQuery()) {
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("nombre") %></td>
                                <td><%= rs.getString("stock") %></td>
                            </tr>
                            <%
                                    }
                                } catch (SQLException e) {
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasSidebar" aria-labelledby="offcanvasSidebarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasSidebarLabel">Menú</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Cerrar"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#submenuMobile" role="button" aria-expanded="false" aria-controls="submenuMobile">
                            Estadísticas <i class="fa-solid fa-arrow-down"></i>
                        </a>
                        <div class="collapse ps-3" id="submenuMobile">
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
        </div>
        <script src="script.js"></script>
    </body>
</html>