# Syntax Laudis — Cancionero litúrgico

**Syntax Laudis** es un cancionero litúrgico de consulta libre para coro. Reúne cantos populares en PDF, organizados por momento litúrgico, para tener letras y acordes de guitarra disponibles durante ensayos, celebraciones y preparación pastoral.

> **Cantare, Laudare, Orare — in Choro**

## Estado de esta versión

Esta versión visual queda alineada con el estilo de **Ordo Laudis**:

- encabezado sobrio en negro, marfil y dorado;
- tipografía **Literata**;
- cruz central como marca visual;
- tarjetas con bordes definidos;
- buscador con coincidencias sin depender de acentos;
- índice rápido por secciones;
- secciones colapsables;
- botón dinámico para volver arriba.

El cancionero contiene actualmente **138 cantos** distribuidos en **15 secciones**.

## Uso

1. Abre `index.html` desde GitHub Pages.
2. Usa el buscador para encontrar un canto por nombre o por sección.
3. Usa el índice rápido para saltar al momento litúrgico correspondiente.
4. Abre el PDF del canto en una pestaña nueva.

## Estructura esperada

La página espera que los PDFs se conserven en carpetas por sección, por ejemplo:

```text
SyntaxLaudis-Pages/
├── index.html
├── README.md
├── Entrada/
│   └── Nombre_del_canto.pdf
├── Comunion/
│   └── Nombre_del_canto.pdf
└── ...
```

## Cómo agregar un canto

En `index.html`, localiza la sección correspondiente y agrega una entrada como esta dentro de la lista:

```html
<li class="song-item" data-search="Entrada Nombre del canto">
  <a class="song-link" href="Entrada/Nombre_del_canto.pdf" target="_blank" rel="noopener">Nombre del canto</a>
</li>
```

Recomendaciones:

- usa nombres de archivo sin acentos cuando sea posible;
- evita espacios en nombres de archivo nuevos y prefiere guiones bajos;
- verifica que el enlace coincida exactamente con el nombre del PDF y la carpeta;
- conserva la sección litúrgica más útil para el coro.

## Publicación en GitHub Pages

1. Sube o reemplaza `index.html` y `README.md` en el repositorio `SyntaxLaudis-Pages`.
2. Conserva intactas las carpetas de PDFs.
3. Haz commit en la rama publicada por GitHub Pages.
4. Abre la página y, si el navegador muestra una versión anterior, prueba recargar con `Ctrl + F5` o agregar un parámetro temporal como `?v=2`.

## Aviso y créditos

Syntax Laudis es un proyecto **personal, pastoral y no oficial**. No pertenece a una diócesis, parroquia, editorial, autor, compositor ni entidad eclesial oficial.

Los cantos, letras, melodías, armonizaciones y arreglos pertenecen a sus respectivos autores, compositores, editoriales o titulares de derechos. Este sitio se ofrece únicamente como herramienta de consulta para uso pastoral, formativo y de apoyo al coro.

El proyecto no pretende sustituir libros litúrgicos, cantorales oficiales, partituras autorizadas, licencias de uso musical, materiales editoriales ni criterios pastorales de la comunidad celebrante.

Si algún titular de derechos desea solicitar corrección, atribución, modificación o retiro de algún material, el contenido puede revisarse o retirarse del repositorio.

## Relación con Ordo Laudis

Syntax Laudis forma parte del mismo ecosistema de herramientas personales que **Ordo Laudis**. Mientras Ordo Laudis se orienta a la Liturgia de las Horas y al Misal diario, Syntax Laudis se enfoca en la música litúrgica de consulta para coro.

## Nota técnica

La página está hecha sólo con HTML, CSS y JavaScript básico. No requiere servidor, base de datos ni instalación adicional.
