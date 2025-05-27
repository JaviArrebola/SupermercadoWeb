package packClass;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Clase utilitaria para generar un hash SHA-256 de una cadena de texto.
 */
public class SHA256 {

    /**
     * Genera un hash SHA-256 a partir de la cadena de entrada.
     *
     * @param a La cadena de texto que se desea hashear.
     * @return El hash resultante en formato hexadecimal.
     * @throws NoSuchAlgorithmException Si el algoritmo SHA-256 no está
     * disponible.
     */
    public static String generateSHA(String a) throws NoSuchAlgorithmException {
        // Obtiene una instancia del algoritmo SHA-256
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        
        // Calcula el hash de la cadena de entrada como un arreglo de bytes
        byte[] encoded = digest.digest(a.getBytes());
        
        // StringBuilder para construir la representación hexadecimal del hash
        StringBuilder hex = new StringBuilder();
        
        // Convierte cada byte del hash a formato hexadecimal
        for (byte b : encoded) {
            // Aplica una máscara para convertir el byte a un valor positivo y luego a hexadecimal
            String code = Integer.toHexString(0xff & b);
            
            // Asegura que cada byte esté representado por dos dígitos (añade un 0 si es necesario)
            if (code.length() == 1) {
                hex.append('0');
            }
            
            // Añade el código hexadecimal al resultado final
            hex.append(code);
        }
        
        // Devuelve el hash completo en formato hexadecimal
        return hex.toString();
    }
}
