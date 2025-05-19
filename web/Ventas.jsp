<%-- 
    Document   : Ventas
    Created on : 16 may 2025, 13:23:00
    Author     : ikasle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link href="style.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="imagenes/icon.png">

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
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
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
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                        Añadir Producto
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table-custom">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Codigo_Barras</th>
                                <th></th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Alargador</td>
                                <td>5</td>
                                <td>79</td>
                                <td>8412852562445</td>
                                <td>
                                    <i class="fa-solid fa-pen-to-square icon-btn" style="color:greenyellow" title="Editar"></i>
                                    <i class="fa-solid fa-trash icon-btn delete" style="color:red; cursor:pointer;" title="Eliminar"></i>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
