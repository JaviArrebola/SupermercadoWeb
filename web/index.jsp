<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css"/>
        <link rel="icon" type="image/x-icon" href="imagenes/icon.png">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="login-container">
            <div class="login-box">
                <div class="login-left">
                    <h3 class="mb-4"><strong>Inicio de sesion</strong></h3>

                    <%
                        String error =(String) session.getAttribute("error");
                        if (error != null) {
                    %>
                            <div class="alert alert-danger" role="alert">
                                <%= error %>
                            </div>          
                    <%  
                        session.removeAttribute("error");
                        }
                    %>

                    <form action="inicioSesion" method="post">
                        <div class="mb-3">
                            <label for="nombre">Nombre</label>
                            <input type="text" name="nombre" class="form-control" placeholder="Nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="password">Contraseña</label>
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                        </div> 
                        <div class="d-grid">
                            <button type="submit" class="btn btn-login d-grid">Entrar</button>
                        </div>
                    </form>
                </div>
                <div class="login-right">
                    <img src="imagenes/icon.png" alt="Descripción de la imagen" width="300">
                </div>
            </div>
        </div>
    </body>
</html>
