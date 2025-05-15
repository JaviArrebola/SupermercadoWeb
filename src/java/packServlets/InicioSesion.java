package packServlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class InicioSesion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String usuario = request.getParameter("nombre");
        String password = request.getParameter("password");

        final String USUARIO = "Borja";
        final String PASSWORD = "1234";

        String enviarPagina = "";

        if (usuario != null && usuario.equals(USUARIO)) {
            System.out.println("Usuario existe");

            if (password != null && password.equals(PASSWORD)) {
                System.out.println("Inicio de sesión correcto");

                enviarPagina = "productos.jsp";
                session.setAttribute("usuario", usuario); 
            } else {
                System.out.println("Contraseña incorrecta");
                enviarPagina = "index.jsp?error=passwordnotcorrect";
            }
        } else {
            System.out.println("Usuario no existe");
            enviarPagina = "index.jsp?error=usernotexist";
        }

        response.sendRedirect(enviarPagina);
    }



    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
