document.getElementById('ordenarTabla').addEventListener('change', function () {
    const criterio = this.value;
    const tabla = document.querySelector('.table-custom tbody');
    const filas = Array.from(tabla.querySelectorAll('tr'));

    filas.sort((a, b) => {
        let valorA, valorB;
        const [campo, direccion] = criterio.split('-');

        switch (campo) {
            case 'id':
                valorA = parseInt(a.cells[0].textContent.trim());
                valorB = parseInt(b.cells[0].textContent.trim());
                break;
            case 'nombre':
                valorA = a.cells[1].textContent.trim().toLowerCase();
                valorB = b.cells[1].textContent.trim().toLowerCase();
                break;
            case 'precio':
                valorA = parseFloat(a.cells[2].textContent.trim().replace(',', '.'));
                valorB = parseFloat(b.cells[2].textContent.trim().replace(',', '.'));
                break;
            case 'stock':
                valorA = parseInt(a.cells[3].textContent.trim());
                valorB = parseInt(b.cells[3].textContent.trim());
                break;
            case 'codigo':
                valorA = a.cells[4].textContent.trim();
                valorB = b.cells[4].textContent.trim();
                break;
            default:
                return 0;
        }

        if (typeof valorA === 'string') {
            return direccion === 'asc' ? valorA.localeCompare(valorB) : valorB.localeCompare(valorA);
        } else {
            return direccion === 'asc' ? valorA - valorB : valorB - valorA;
        }
    });

    while (tabla.firstChild) {
        tabla.removeChild(tabla.firstChild);
    }
    filas.forEach(fila => tabla.appendChild(fila));
});
