<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Error de Conexión</title>
        <link rel="icon" type="image/x-icon" href="imagenes/icon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light d-flex justify-content-center align-items-center vh-100">

        <div class="container text-center">
            <!-- Card para destacar el error -->
            <div class="card shadow-lg border-danger">
                <div class="card-body">
                    <h1 class="card-title text-danger mb-4">❌ Error de Conexión</h1>
                    <p class="card-text fs-5">No se ha podido establecer conexión con la base de datos.</p>
                    <p class="card-text text-muted">Por favor, verifica tu conexión o contacta con el administrador.</p>
                    <a href="index.jsp" class="btn btn-primary mt-3">Volver al Inicio</a>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
