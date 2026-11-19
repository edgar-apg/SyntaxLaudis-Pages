
[CmdletBinding()]
param(
    [switch]$Aplicar
)

$ErrorActionPreference = "Stop"

# Rutas
$PagesPath = Split-Path -Parent $PSScriptRoot
$PreviewPath = Join-Path $env:TEMP "SyntaxLaudis\VistaPrevia"
$BackupRoot = Join-Path $env:TEMP "SyntaxLaudis\Respaldos"

# Secciones oficiales del sitio
$OfficialSections = @(
    "Adoracion",
    "Alabanza",
    "Aleluya",
    "Aspersion",
    "Comunion",
    "Cordero-de-Dios",
    "Dominicos",
    "Entrada",
    "Esquemas-completos",
    "Franciscanos",
    "Gloria",
    "Honor-y-Gloria",
    "Marianos",
    "Navidad",
    "Ofertorio",
    "Padre-Nuestro",
    "Reflexion",
    "Salida",
    "Santo",
    "Senor-ten-piedad",
    "Villancicos"
)

Write-Host "`n=== ACTUALIZACIÓN DE SYNTAX LAUDIS ===" -ForegroundColor Cyan
Write-Host "Origen:  $PreviewPath"
Write-Host "Destino: $PagesPath"

# Validar rutas
if (-not (Test-Path -LiteralPath $PreviewPath -PathType Container)) {
    throw "No existe la carpeta de vista previa: $PreviewPath"
}

$PreviewIndex = Join-Path $PreviewPath "index.html"

if (-not (Test-Path -LiteralPath $PreviewIndex -PathType Leaf)) {
    throw "No existe index.html en la vista previa."
}

if (-not (Test-Path -LiteralPath $PagesPath -PathType Container)) {
    throw "No existe la carpeta del repositorio Pages."
}

# Construir lista de archivos que se copiarán
$Operations = @()

$Operations += [PSCustomObject]@{
    Source      = $PreviewIndex
    Destination = Join-Path $PagesPath "index.html"
    Relative    = "index.html"
}

foreach ($section in $OfficialSections) {
    $sourceSection = Join-Path $PreviewPath $section

    if (-not (Test-Path -LiteralPath $sourceSection -PathType Container)) {
        Write-Warning "No existe en la vista previa: $section"
        continue
    }

    $pdfFiles = Get-ChildItem -LiteralPath $sourceSection -File -Filter "*.pdf"

    foreach ($pdf in $pdfFiles) {
        $relativePath = Join-Path $section $pdf.Name

        $Operations += [PSCustomObject]@{
            Source      = $pdf.FullName
            Destination = Join-Path $PagesPath $relativePath
            Relative    = $relativePath
        }
    }
}

if ($Operations.Count -eq 0) {
    throw "No se encontraron archivos para actualizar."
}

# Clasificar operaciones
$Existing = @($Operations | Where-Object {
    Test-Path -LiteralPath $_.Destination -PathType Leaf
})

$New = @($Operations | Where-Object {
    -not (Test-Path -LiteralPath $_.Destination -PathType Leaf)
})

Write-Host "`nResumen de actualización:" -ForegroundColor Cyan
Write-Host "  Archivos por copiar:       $($Operations.Count)"
Write-Host "  Archivos que se reemplazan: $($Existing.Count)"
Write-Host "  Archivos nuevos:            $($New.Count)"
Write-Host "  Archivos que se eliminarán: 0"

Write-Host "`nArchivos incluidos:" -ForegroundColor Gray

foreach ($operation in $Operations) {
    if (Test-Path -LiteralPath $operation.Destination -PathType Leaf) {
        Write-Host "  [REEMPLAZAR] $($operation.Relative)" -ForegroundColor Yellow
    }
    else {
        Write-Host "  [NUEVO]      $($operation.Relative)" -ForegroundColor Green
    }
}

# Simulación por defecto
if (-not $Aplicar) {
    Write-Host "`nSIMULACIÓN: no se modificó ningún archivo público." -ForegroundColor Cyan
    Write-Host "Para aplicar los cambios, ejecuta:"
    Write-Host ".\scripts\aplicar-actualizacion.ps1 -Aplicar" -ForegroundColor Yellow
    exit 0
}

# Confirmación explícita
Write-Host "`nATENCIÓN: se modificarán archivos de SyntaxLaudis-Pages." -ForegroundColor Yellow
Write-Host "Los archivos existentes tendrán respaldo antes de reemplazarse."

$confirmation = Read-Host "Escribe APLICAR para continuar"

if ($confirmation -cne "APLICAR") {
    Write-Host "`nOperación cancelada. No se modificó ningún archivo." -ForegroundColor Yellow
    exit 0
}

# Crear carpeta de respaldo
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$BackupPath = Join-Path $BackupRoot $timestamp

New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null

Write-Host "`nAplicando actualización..." -ForegroundColor Cyan

$copied = 0
$backedUp = 0

foreach ($operation in $Operations) {
    $destinationDirectory = Split-Path -Parent $operation.Destination

    New-Item -ItemType Directory -Path $destinationDirectory -Force |
        Out-Null

    # Respaldar únicamente archivos que serán reemplazados
    if (Test-Path -LiteralPath $operation.Destination -PathType Leaf) {
        $backupFile = Join-Path $BackupPath $operation.Relative
        $backupDirectory = Split-Path -Parent $backupFile

        New-Item -ItemType Directory -Path $backupDirectory -Force |
            Out-Null

        Copy-Item -LiteralPath $operation.Destination -Destination $backupFile -Force
        $backedUp++
    }

    # Copiar archivo nuevo o actualizado
    Copy-Item -LiteralPath $operation.Source -Destination $operation.Destination -Force
    $copied++
}

Write-Host "`n[OK] Actualización completada." -ForegroundColor Green
Write-Host "  Archivos copiados: $copied"
Write-Host "  Respaldos creados: $backedUp"
Write-Host "  Respaldo: $BackupPath"

Write-Host "`nNo se ejecutaron comandos de Git ni se publicó en GitHub." -ForegroundColor Cyan
