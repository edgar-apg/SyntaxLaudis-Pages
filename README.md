# Syntax Laudis — Cancionero litúrgico

**Syntax Laudis** es un cancionero litúrgico de consulta libre para coro. Reúne cantos populares en PDF, organizados por momento litúrgico, para tener letras y acordes de guitarra disponibles durante ensayos, celebraciones y preparación pastoral.

> **Cantare, Laudare, Orare — in Choro**

## Sitio público

El cancionero está publicado en GitHub Pages:

```text
https://edgar-apg.github.io/SyntaxLaudis-Pages
```

Después de cada `git push`, GitHub Pages puede tardar uno o dos minutos en reflejar los cambios. Si el navegador conserva una versión anterior, conviene recargar con `Ctrl + F5` o abrir la página con un parámetro temporal, por ejemplo `?v=2`.

## Estado de esta versión

Esta versión visual queda alineada con el estilo de **Ordo Laudis**:

- encabezado sobrio en negro, marfil y dorado;
- tipografía **Literata**;
- cruz central como marca visual;
- tarjetas con bordes definidos;
- buscador con coincidencias sin depender de acentos;
- índice rápido por momento litúrgico;
- vista limpia: ninguna sección se despliega hasta elegirla;
- botón circular y dinámico para volver arriba.

El cancionero contiene actualmente **138 cantos** distribuidos en **15 secciones**. En la página pública, las secciones permanecen ocultas al inicio y sólo se muestra la sección elegida desde el índice rápido; al buscar por nombre se muestran automáticamente las coincidencias.

## Estructura del proyecto

Syntax Laudis se trabaja con dos repositorios complementarios:

```text
Eclesia/
├── Cancionero/                  repositorio privado: SyntaxLaudis
│   ├── Cantos/                  archivos .chordpro por sección
│   ├── PDFs/                    PDFs generados, ignorados por Git
│   ├── config/
│   │   └── mi-estilo.json       estilo de exportación
│   └── exportar-cantos.ps1      script principal
│
└── SyntaxLaudis-Pages/          repositorio público: GitHub Pages
    ├── Adoracion/
    ├── Comunion/
    ├── Entrada/
    ├── ...
    ├── index.html               página pública del cancionero
    └── README.md
```

La fuente de trabajo está en el repositorio privado **SyntaxLaudis**. La página publicada vive en **SyntaxLaudis-Pages**.

## Flujo de trabajo recomendado

Cuando se agrega o edita un canto:

1. Editar el archivo `.chordpro` en VS Code dentro del repositorio privado `Cancionero`.
2. Ejecutar el script principal en PowerShell:

```powershell
cd "C:\Users\edgar\OneDrive\Eclesia\Cancionero"
.\exportar-cantos.ps1
```

3. Elegir en el script la opción correspondiente:
   - opción 1: exportar un canto;
   - opción 2: exportar todo el cancionero.

El script se encarga de:

- exportar el PDF con ChordPro;
- copiar el PDF al repositorio `SyntaxLaudis-Pages`;
- actualizar `index.html`;
- hacer `push` a GitHub en ambos repositorios.

## Estructura básica de un archivo `.chordpro`

```chordpro
{title: Nombre del canto}
{subtitle: Autor}
{key: G}
{capo: 2}

[G]Primera línea de [C]letra
[D]Segunda línea de [G]letra

{start_of_chorus}
[Em]Estribillo primera [C]línea
[G]Estribillo segunda [D]línea
{end_of_chorus}
```

La directiva `{title:}` es importante porque el script la usa para extraer el nombre correcto del canto y agregarlo al índice público.

## Comandos Git útiles

Ver el estado de cambios:

```powershell
git status
```

Subir cambios manualmente:

```powershell
git add .
git commit -m "Descripción del cambio"
git push
```

Bajar cambios desde GitHub antes de trabajar en otra computadora:

```powershell
git pull
```

## Configuración en una PC nueva

1. Instalar Strawberry Perl.
2. Instalar ChordPro desde PowerShell:

```powershell
cpanm App::Music::ChordPro
```

3. Verificar la instalación:

```powershell
chordpro --version
```

4. Instalar Git.
5. Configurar identidad en Git:

```powershell
git config --global user.name "Tu Nombre"
git config --global user.email "tu@correo.com"
```

6. Clonar los repositorios:

```powershell
cd "C:\Users\edgar\OneDrive\Eclesia"
git clone https://github.com/edgar-apg/SyntaxLaudis.git Cancionero
git clone https://github.com/edgar-apg/SyntaxLaudis-Pages.git
```

7. Probar la exportación con el script:

```powershell
cd "C:\Users\edgar\OneDrive\Eclesia\Cancionero"
.\exportar-cantos.ps1
```

## Archivos clave

### `config\mi-estilo.json`

Define fuentes, tamaños y estilo visual del PDF exportado desde ChordPro.

### `exportar-cantos.ps1`

Script principal. Exporta cantos, copia PDFs, actualiza `index.html` y hace `push` a GitHub automáticamente.

### `SyntaxLaudis-Pages\index.html`

Página web pública del cancionero. Se actualiza cuando el script modifica el índice y publica los cambios.

## Recomendaciones de mantenimiento

- Hacer `git pull` antes de empezar a trabajar, especialmente si se alterna entre laptop y PC.
- Hacer `git status` antes y después de ejecutar el script.
- Evitar tildes y espacios en nombres de archivos y carpetas.
- Usar guiones bajos en nombres de archivo, por ejemplo: `Pescador_de_hombres.chordpro`.
- Verificar que cada `.chordpro` tenga `{title:}`.
- Revisar el sitio público después de cada publicación.
- Si un archivo `.chordpro` está vacío, ChordPro puede omitirlo con advertencia; eso no necesariamente indica un error del script.

## Aviso y créditos

Syntax Laudis es un proyecto **personal, pastoral y no oficial**. No pertenece a una diócesis, parroquia, editorial, autor, compositor ni entidad eclesial oficial.

Los cantos, letras, melodías, armonizaciones y arreglos pertenecen a sus respectivos autores, compositores, editoriales o titulares de derechos. Este sitio se ofrece únicamente como herramienta de consulta para uso pastoral, formativo y de apoyo al coro.

El proyecto no pretende sustituir libros litúrgicos, cantorales oficiales, partituras autorizadas, licencias de uso musical, materiales editoriales ni criterios pastorales de la comunidad celebrante.

Si algún titular de derechos desea solicitar corrección, atribución, modificación o retiro de algún material, el contenido puede revisarse o retirarse del repositorio.

## Relación con Ordo Laudis

Syntax Laudis forma parte del mismo ecosistema de herramientas personales que **Ordo Laudis**. Mientras Ordo Laudis se orienta a la Liturgia de las Horas y al Misal diario, Syntax Laudis se enfoca en la música litúrgica de consulta para coro.

## Nota técnica

La página está hecha sólo con HTML, CSS y JavaScript básico. No requiere servidor, base de datos ni instalación adicional para consultarse desde GitHub Pages.
