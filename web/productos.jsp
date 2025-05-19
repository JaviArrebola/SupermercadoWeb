<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packDB.ConexionDB"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <link href="style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar px-3 custom-navbar">
        <div class="d-flex align-items-center">
            <img src="imagenes/icon.png" alt="Supermercado" width="40" class="me-2">
            <span class="navbar-brand mb-0 h1">Supermercado</span>
        </div>
    </nav>

    <div class="d-flex" style="height: calc(100vh - 56px);">
        <div class="sidebar p-3">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="Productos.jsp">Productos</a></li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#submenu" role="button" aria-expanded="false" aria-controls="submenu">
                        Estadísticas <i class="fa-solid fa-arrow-down"></i>
                    </a>
                    <div class="collapse ps-3" id="submenu">
                        <ul class="nav flex-column">
                            <li class="nav-item"><a class="nav-link" href="Ventas.jsp">Ventas</a></li>
                            <li class="nav-item"><a class="nav-link" href="ProductosVendidos.jsp">Productos vendidos</a></li>
                            <li class="nav-item"><a class="nav-link" href="StockProductos.jsp">Stock productos</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item"><a class="nav-link" href="index.jsp">Cerrar Sesión</a></li>
            </ul>
        </div>

        <div class="flex-grow-1 p-4 content-area">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Lista de Productos</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoProducto">
                    <i class="bi bi-plus-lg"></i> Nuevo producto
                </button>
            </div>

            <div class="table-responsive">
                <table class="table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Precio Unitario</th>
                            <th>Artículos en stock</th>
                            <th>Código de barras</th>
                            <th></th>
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
                            <td><%= rs.getString("precio") %></td>
                            <td><%= rs.getString("stock") %></td>
                            <td><%= rs.getString("codigo_barras") %></td>
                            <td class="text-center">
                                <i class="fa-solid fa-pen-to-square icon-btn" style="color:greenyellow" title="Editar"></i>
                                <i class="fa-solid fa-trash icon-btn delete" style="color:red" title="Eliminar"></i>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalNuevoProducto" tabindex="-1" aria-labelledby="modalNuevoProductoLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalNuevoProductoLabel">Nuevo Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="nombreProducto" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombreProducto">
                        </div>
                        <div class="mb-3">
                            <label for="precioProducto" class="form-label">Precio</label>
                            <input type="number" class="form-control" id="precioProducto">
                        </div>
                        <div class="mb-3">
                            <label for="stockProducto" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="stockProducto">
                        </div>
                        <div class="mb-3">
                            <label for="codigoBarras" class="form-label">Código de Barras</label>
                            <input type="text" class="form-control" id="codigoBarras">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary">Añadir</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
