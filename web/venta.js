
document.addEventListener('DOMContentLoaded', function () {
    const ordenarTablaVenta = document.getElementById('ordenarTablaVenta');
    if (ordenarTablaVenta) {
        ordenarTablaVenta.addEventListener('change', function () {
            ordenarFilasVenta(this.value);
        });
    }
});

function ordenarFilasVenta(criterio) {
    const tabla = document.querySelector('#tablaVentas table tbody');
    const filas = Array.from(tabla.querySelectorAll('tr'));

    filas.sort((a, b) => {
        const [idA, fechaA, totalA] = Array.from(a.children).map(td => td.textContent.trim());
        const [idB, fechaB, totalB] = Array.from(b.children).map(td => td.textContent.trim());

        switch (criterio) {
            case 'idv-asc':
                return parseInt(idA) - parseInt(idB);
            case 'idv-desc':
                return parseInt(idB) - parseInt(idA);
            case 'fechav-asc':
                return new Date(fechaA) - new Date(fechaB);
            case 'fechav-desc':
                return new Date(fechaB) - new Date(fechaA);
            case 'totalv-asc':
                return parseFloat(totalA) - parseFloat(totalB);
            case 'totalv-desc':
                return parseFloat(totalB) - parseFloat(totalA);
            default:
                return 0;
        }
    });

    filas.forEach(fila => tabla.appendChild(fila));
}


