<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <li class="nav-item"><a class="nav-link" href="#">Productos</a></li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#submenu" role="button" aria-expanded="false" aria-controls="submenu">
                            Estadisticas       <i class="fa-solid fa-arrow-down"></i>
                        </a>
                        <div class="collapse ps-3" id="submenu">
                            <ul class="nav flex-column">
                                <li class="nav-item"><a class="nav-link" href="#">Ventas</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Productos vendidos</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Stock productos</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Cerrar Sesion</a></li>
                </ul>
            </div>
            <div class="flex-grow-1 p-4 content-area">
                <h2 class="mb-4">Lista de Productos</h2>
                <div class="table-responsive">
                    <table class="table-custom">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Usuario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>
                                    <i class="fa-solid fa-pen-to-square icon-btn"style="color:greenyellow" title="Editar"></i>
                                    <i class="fa-solid fa-trash icon-btn delete"style="color:red" title="Eliminar"></i>
                                </td>
                            </tr>
                          
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </body>
</html>

