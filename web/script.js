// Función para asignar el ID del producto a un campo oculto, usado para eliminar el producto
function eliminarProducto(id) {
    document.getElementById("idProducto").value = id;
}

// Función para rellenar el formulario de edición con los datos del producto seleccionado
function editarProducto(nombre, stock, precio, codigoBarras) {
    document.getElementById("nombreProductoEditar").value = nombre;
    document.getElementById("precioProductoEditar").value = precio;
    document.getElementById("stockProductoEditar").value = stock;
    document.getElementById("codigoBarrasEditar").value = codigoBarras;
}

// Función para asignar el ID del producto al formulario de edición (campo oculto)
function insertarId(idProducto) {
    document.getElementById("idProductoEditar").value = idProducto;
}

// Espera a que el DOM esté completamente cargado antes de ejecutar el código
document.addEventListener("DOMContentLoaded", function () {
    // Configuración de selectores para ordenar diferentes tablas y sus selectores de ordenamiento
    const ordenadores = [
        {id: "ordenarTablaVentas", tabla: "tablaVentas"},
        {id: "ordenarTablaVendidos", tabla: "tablaVendidos"},
        {id: "ordenarTablaStock", tabla: "tablaStock"}
    ];

    // Para cada par selector-tabla, añade un listener que ordena la tabla al cambiar la opción
    ordenadores.forEach(config => {
        const select = document.getElementById(config.id);
        const tabla = document.getElementById(config.tabla);

        if (select && tabla) {
            // Al cambiar la opción de ordenamiento, se extraen columna y orden para ordenar la tabla
            select.addEventListener("change", function () {
                const [columna, orden] = this.value.split("-");
                ordenarTabla(tabla, parseInt(columna), orden);
            });
        }
    });

    // Función para verificar si una cadena tiene formato de fecha ISO (YYYY-MM-DD HH:mm:ss)
    function esFechaISO(str) {
        return /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/.test(str);
    }

    // Función para ordenar una tabla HTML según columna e orden (ascendente o descendente)
    function ordenarTabla(tabla, indiceColumna, orden) {
        const cuerpo = tabla.querySelector("tbody");
        const filas = Array.from(cuerpo.querySelectorAll("tr"));

        filas.sort((a, b) => {
            const aTexto = a.children[indiceColumna].textContent.trim();
            const bTexto = b.children[indiceColumna].textContent.trim();

            let resultado = 0;

            if (!isNaN(aTexto) && !isNaN(bTexto)) {
                resultado = parseFloat(aTexto) - parseFloat(bTexto);
            } else if (esFechaISO(aTexto) && esFechaISO(bTexto)) {
                resultado = new Date(aTexto) - new Date(bTexto);
            } else {
                resultado = aTexto.localeCompare(bTexto);
            }

            return orden === "asc" ? resultado : -resultado;
        });

        filas.forEach(fila => cuerpo.appendChild(fila));
    }
});
