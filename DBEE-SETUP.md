# DBee Configuration Guide

## ✅ Configuración Completada

Se ha configurado **nvim-dbee** como cliente SQL para Neovim con las siguientes características:

### 🔧 Características Configuradas

- **Lazy loading**: Se carga solo al usar el comando `:Dbee`
- **Múltiples fuentes de conexión**: FileSource, EnvSource y MemorySource
- **UI personalizada**: Layout con drawer (30%), editor (60%) y resultados (40%)
- **Keybindings intuitivos**: Navegación y ejecución de queries
- **Soporte para múltiples DBs**: PostgreSQL, MySQL, SQLite, MongoDB, Redis
- **Manejo seguro de credenciales**: Variables de entorno con templates Go
- **Paginación automática**: 100 filas por página
- **Exportación de resultados**: JSON, CSV, tabla

### ⌨️ Keybindings Principales

#### Keybindings Globales:
- `<leader>db` - Abrir Database UI
- `<leader>dt` - Toggle Database UI  
- `<leader>dc` - Cerrar Database UI
- `<leader>de` - Ejecutar query actual/seleccionado
- `<leader>dn` - Página siguiente de resultados
- `<leader>dp` - Página anterior de resultados
- `<leader>ds` - Guardar resultados a archivo

#### Dentro del UI de DBee:
- `o` - Toggle nodo del árbol
- `<CR>` - Acción en nodo (abrir/conectar)
- `r` - Refrescar árbol
- `cw` - Editar conexión
- `dd` - Eliminar conexión/scratchpad
- `<C-n>` - Nuevo scratchpad

#### En el editor SQL:
- `BB` - Ejecutar archivo completo (normal) o selección (visual)
- `<leader>w` - Guardar scratchpad

#### En resultados:
- `L/H` - Navegar páginas (siguiente/anterior)
- `E/F` - Ir a última/primera página
- `yaj/yac` - Copiar fila actual como JSON/CSV
- `yaJ/yaC` - Copiar todos los resultados como JSON/CSV

### 🔐 Configuración de Conexiones

#### Método 1: Variables de Entorno
```bash
export DBEE_CONNECTIONS='[
  {
    "name": "Mi Base de Datos",
    "type": "postgres",
    "url": "postgres://user:pass@localhost:5432/dbname?sslmode=disable"
  }
]'
```

#### Método 2: Archivo JSON (recomendado)
Las conexiones se guardan automáticamente en:
`~/.local/share/nvim/dbee/connections.json`

Ver ejemplo en: `dbee-connections-example.json`

#### Método 3: Variables de Entorno Seguras
```bash
# Definir credenciales
export DB_USER="myuser"
export DB_PASS="mypass"
export DB_NAME="mydb"

# Usar en conexión con templates
export DBEE_CONNECTIONS='[
  {
    "name": "Secure Database",
    "type": "postgres", 
    "url": "postgres://{{ env \"DB_USER\" }}:{{ env \"DB_PASS\" }}@localhost:5432/{{ env \"DB_NAME\" }}?sslmode=disable"
  }
]'
```

### 🚀 Primeros Pasos

1. **Instalar y cargar el plugin**:
   ```
   :Lazy sync
   ```

2. **Abrir DBee**:
   ```
   <leader>db
   ```

3. **Configurar tu primera conexión**:
   - Navega al drawer (panel izquierdo)
   - Presiona `<CR>` en "add" para nueva conexión
   - Completa los datos y guarda con `:w`

4. **Crear tu primer scratchpad**:
   - Presiona `<CR>` en "new" bajo scratchpads
   - Escribe tu query SQL
   - Ejecuta con `BB` (archivo completo) o selecciona y usa `BB`

5. **Ver resultados**:
   - Los resultados aparecen en el panel inferior
   - Navega con `L/H` entre páginas
   - Copia resultados con `yaj` (JSON) o `yac` (CSV)

### 🗃️ Tipos de Base de Datos Soportados

- **PostgreSQL**: `type: "postgres"`
- **MySQL/MariaDB**: `type: "mysql"`  
- **SQLite**: `type: "sqlite"`
- **MongoDB**: `type: "mongo"`
- **Redis**: `type: "redis"`
- **DuckDB**: `type: "duckdb"`
- **ClickHouse**: `type: "clickhouse"`

### 📁 Estructura de Archivos

```
~/.local/share/nvim/dbee/
├── connections.json     # Conexiones persistentes
├── example.db          # Base SQLite de ejemplo
└── scratchpads/        # Scripts SQL guardados
```

### 🔧 Solución de Problemas

1. **Plugin no carga**: Ejecuta `:Lazy sync` para instalar
2. **Binario no encontrado**: El binario Go se descarga automáticamente
3. **Conexión falla**: Verifica credenciales y que la DB esté corriendo
4. **Variables de entorno**: Usa templates Go: `{{ env "VARIABLE" }}`

### 📖 Recursos Adicionales

- [Documentación oficial](https://github.com/kndndrj/nvim-dbee)
- [Ejemplos de conexión](./dbee-connections-example.json)
- Video tutorial disponible en el repositorio de GitHub

---

¡Tu configuración de DBee está lista! Usa `<leader>db` para comenzar. 🎉