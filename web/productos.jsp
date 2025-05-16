<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                            Opciones
                        </a>
                        <div class="collapse ps-3" id="submenu">
                            <ul class="nav flex-column">
                                <li class="nav-item"><a class="nav-link" href="#">Action</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Another action</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Something else here</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="nav-item"><a class="nav-link" href="#">Cerrar Sesion</a></li>
                </ul>
            </div>


            <div class="flex-grow-1 p-4 content-area">
                <h2 class="mb-4">Lista de Productos</h2>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Usuario</th>
                                <th></th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Nombre</td>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td><img src="imagenes/IconoLapiz.png" alt="Eliminar" width="24">
                                    <img src="imagenes/IconoBasura.png" alt="Eliminar" width="24">
                                </td>

                            </tr>
                            <tr>
                                <td>Precio</td>
                                <td>Jacob</td>
                                <td>Thornton</td>
                                <td>@fat</td>
                                <td><img src="imagenes/IconoLapiz.png" alt="Eliminar" width="24">
                                    <img src="imagenes/IconoBasura.png" alt="Eliminar" width="24">
                                </td>
                            </tr>
                            <tr>
                                <td>Stock</td>
                                <td>Jacob</td>
                                <td>Thornton</td>
                                <td>@fat</td>
                                <td><img src="imagenes/IconoLapiz.png" alt="Eliminar" width="24">
                                    <img src="imagenes/IconoBasura.png" alt="Eliminar" width="24">
                                </td>
                            </tr>
                            <tr>
                                <td>Stock</td>
                                <td>Larry the Bird</td>
                                <td>Larry the Bird</td>
                                <td>@twitter</td>
                                <td><img src="imagenes/IconoLapiz.png" alt="Eliminar" width="24">
                                    <img src="imagenes/IconoBasura.png" alt="Eliminar" width="24">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>

