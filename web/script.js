document.addEventListener("DOMContentLoaded", function () {
    const ordenadores = [
        { id: "ordenarTablaVentas", tabla: "tablaVentas" },
        { id: "ordenarTablaVendidos", tabla: "tablaVendidos" },
        { id: "ordenarTablaStock", tabla: "tablaStock" }
    ];

    ordenadores.forEach(config => {
        const select = document.getElementById(config.id);
        const tabla = document.getElementById(config.tabla);

        if (select && tabla) {
            select.addEventListener("change", function () {
                const [columna, orden] = this.value.split("-");
                ordenarTabla(tabla, parseInt(columna), orden);
            });
        }
    });

    function ordenarTabla(tabla, indiceColumna, orden) {
        const cuerpo = tabla.querySelector("tbody");
        const filas = Array.from(cuerpo.querySelectorAll("tr"));

        const esNumero = filas.every(fila => {
            const texto = fila.children[indiceColumna]?.textContent?.trim();
            return !isNaN(texto) && texto !== "";
        });

        filas.sort((a, b) => {
            const aTexto = a.children[indiceColumna].textContent.trim();
            const bTexto = b.children[indiceColumna].textContent.trim();

            let resultado;
            if (esNumero) {
                resultado = parseFloat(aTexto) - parseFloat(bTexto);
            } else {
                resultado = aTexto.localeCompare(bTexto);
            }

            return orden === "asc" ? resultado : -resultado;
        });

        filas.forEach(fila => cuerpo.appendChild(fila)); // Reorganiza las filas
    }
});
