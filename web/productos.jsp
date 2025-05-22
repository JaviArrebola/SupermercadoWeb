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
        <title>Productos</title>
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
                            <li class="nav-item"><a class="nav-link" href="stockProductos.jsp">Stock productos</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item"><a class="nav-link" href="CerrarSesion">Cerrar Sesión</a></li>
            </ul>
        </div>
        

            <div class="flex-grow-1 p-4 content-area">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Lista de Productos</h2>
                    <div class="d-flex align-items-center gap-3">
                        <label for="ordenarTabla" class="mb-0">Ordenar por:</label>
                        <select id="ordenarTabla" class="form-select form-select-sm" style="width: 150px;">
                            <option value="id-desc">ID (Mayor a Menor)</option>
                            <option value="id-asc">ID (Menor a Mayor)</option>
                            <option value="nombre-asc">Nombre (A → Z)</option>
                            <option value="nombre-desc">Nombre (Z → A)</option>
                            <option value="stock-asc">Stock (Menor a Mayor)</option>
                            <option value="stock-desc">Stock (Mayor a Menor)</option>
                            <option value="precio-asc">Precio (Menor a Mayor)</option>
                            <option value="precio-desc">Precio (Mayor a Menor)</option>
                            <option value="codigo-asc">Código de Barras (A → Z)</option>
                            <option value="codigo-desc">Código de Barras (Z → A)</option>
                        </select>
                        <button
                            class="btn btn-primary"
                            data-bs-toggle="modal"
                            data-bs-target="#modalNuevoProducto"
                            >
                            <i class="bi bi-plus-lg"></i> Nuevo producto
                        </button>
                    </div>
                </div>
                <%
                    String estadoProceso = (String) session.getAttribute("estadoProceso");
                    if(estadoProceso != null){ %>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var modalEstado = document.getElementById('ventanaModal');
                        var modal = new bootstrap.Modal(modalEstado);
                        modal.show();
                    });
                </script>
                <%        
                    }
                    session.removeAttribute("estadoProceso");
                %>

                <div class="modal" id="ventanaModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header bg-success text-dark bg-opacity-50">
                                <h5 class="modal-title">Estado del Proceso</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-primary bg-secondary bg-opacity-10">
                                <p><%= estadoProceso %></p>
                            </div>
                            <div class="modal-footer bg-secondary bg-opacity-25">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
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
                                    <%
                                        String nombre = rs.getString("nombre").replace("'", "\\'");
                                    %>
                                    <i class="fa-solid fa-pen-to-square icon-btn" style="color:greenyellow" onclick="editarProducto('<%= nombre %>',<%= rs.getInt("stock") %>, <%= rs.getDouble("precio") %>, <%= rs.getString("codigo_barras")%>);
                                            insertarId(<%= rs.getInt("id") %>)" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarProducto"></i>
                                    <i
                                        class="fa-solid fa-trash icon-btn delete"
                                        style="color:red; cursor:pointer;"
                                        title="Eliminar"
                                        onclick="eliminarProducto(<%= rs.getInt("id") %>)"
                                        data-bs-toggle="modal"
                                        data-bs-target="#modalConfirmarEliminar"
                                        ></i>
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

        <div
            class="modal fade"
            id="modalNuevoProducto"
            tabindex="-1"
            aria-labelledby="modalNuevoProductoLabel"
            aria-hidden="true"
            >
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="InsertarProducto" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalNuevoProductoLabel">Nuevo Producto</h5>
                            <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Cerrar"
                                ></button>
                        </div>
                        <div class="modal-body">

                            <div class="mb-3">
                                <label for="nombreProductoInsertar" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombreProductoInsertar" name="nombreProductoInsertar" required/>
                            </div>
                            <div class="mb-3">
                                <label for="precioProductoInsertar" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="precioProductoInsertar" name="precioProductoInsertar" step="any" min="0.0" required/>
                            </div>
                            <div class="mb-3">
                                <label for="stockProductoInsertar" class="form-label">Stock</label>
                                <input type="number" class="form-control" id="stockProductoInsertar" name="stockProductoInsertar" min="0" required />
                            </div>
                            <div class="mb-3">
                                <label for="codigoBarrasInsertar" class="form-label">Código de Barras</label>
                                <input type="text" class="form-control" id="codigoBarrasInsertar" name="codigoBarrasInsertar" />
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button
                                type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal"
                                >
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-primary">Añadir</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div
            class="modal fade"
            id="modalConfirmarEliminar"
            tabindex="-1"
            aria-labelledby="modalEliminarLabel"
            aria-hidden="true"
            >
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalEliminarLabel">
                            Confirmar eliminación
                        </h5>
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Cerrar"
                            ></button>
                    </div>
                    <div class="modal-body">
                        ¿Estás seguro de que deseas eliminar este producto?
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                            >
                            Cancelar
                        </button>
                        <form action="EliminarProducto" method="post">
                            <input type="hidden" id="idProducto" name="idProducto" value="" />
                            <button
                                type="submit"
                                class="btn btn-danger"
                                id="btnConfirmarEliminar"
                                >
                                Eliminar
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalEditarProducto" tabindex="-1" aria-labelledby="modalEditarProductoLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="EditarProducto" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalEditarProductoLabel">Editar Producto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">

                            <div class="mb-3">
                                <label for="nombreProductoEditar" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombreProductoEditar" name="nombreProductoEditar">
                            </div>
                            <div class="mb-3">
                                <label for="precioProductoEditar" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="precioProductoEditar" step="any" min="0.0" name="precioProductoEditar">
                            </div>
                            <div class="mb-3">
                                <label for="stockProductoEditar" class="form-label">Stock</label>
                                <input type="number" class="form-control" id="stockProductoEditar" min="0" name="stockProductoEditar">
                            </div>
                            <div class="mb-3">
                                <label for="codigoBarrasEditar" class="form-label">Código de Barras</label>
                                <input type="text" class="form-control" id="codigoBarrasEditar" name="codigoBarrasEditar">
                            </div>
                            <input type="hidden" id="idProductoEditar" name="idProductoEditar" value="">

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Editar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>                

        <script src="script.js"></script>
    </body>
</html>
