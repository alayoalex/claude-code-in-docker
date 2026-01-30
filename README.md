# Claude Code - Entorno Docker

Este proyecto proporciona un entorno Docker para ejecutar Claude Code CLI, permitiéndote trabajar con Claude en un contenedor aislado y portable.

## 📋 Requisitos Previos

- Docker Desktop instalado y en ejecución
- PowerShell (Windows) o acceso a terminal
- API Key de Anthropic (para usar Claude Code) o una de las Suscripciones: Pro, Max, etc.

## 🚀 Inicio Rápido

### 1. Construir la Imagen Docker

```powershell
.\docker-claude.ps1 build
```

Este comando construye la imagen Docker con todas las dependencias necesarias:
- Alpine Linux (base ligera)
- Bash, Git, curl
- Python 3 y pip
- Node.js y npm
- Claude Code CLI
- Herramientas de desarrollo (build-base, vim)

### 2. Iniciar el Contenedor

```powershell
.\docker-claude.ps1 run
```

Esto inicia el contenedor en modo daemon con:
- Montaje del directorio actual en `/workspace`
- Nombre del contenedor: `claude`
- Ejecución en segundo plano

### 3. Acceder al Shell del Contenedor

```powershell
.\docker-claude.ps1 shell
```

Abre una sesión bash interactiva dentro del contenedor.

## 📖 Comandos Disponibles

El script `docker-claude.ps1` proporciona los siguientes comandos:

| Comando | Descripción |
|---------|-------------|
| `build` | Construye la imagen Docker desde el Dockerfile |
| `run` | Inicia el contenedor en modo daemon |
| `stop` | Detiene y elimina el contenedor |
| `shell` | Abre una sesión bash interactiva en el contenedor |
| `restart` | Reinicia el contenedor (stop + run) |
| `clean` | Detiene el contenedor y elimina la imagen Docker |
| `logs` | Muestra los logs del contenedor en tiempo real |
| `status` | Muestra el estado actual del contenedor |

### Ejemplos de Uso

```powershell
# Ver el estado del contenedor
.\docker-claude.ps1 status

# Ver los logs en tiempo real
.\docker-claude.ps1 logs

# Reiniciar el contenedor
.\docker-claude.ps1 restart

# Limpiar todo (contenedor e imagen)
.\docker-claude.ps1 clean
```

## 📁 Estructura del Proyecto

```
claude-code-dockerized/
│
├── Dockerfile              # Definición de la imagen Docker
├── docker-claude.ps1       # Script de gestión de Docker
├── settings.json           # Configuración de permisos para Claude
└── README.md              # Esta guía
```

## ⚙️ Configuración

### settings.json

El archivo `settings.json` contiene los permisos que Claude Code puede ejecutar dentro del contenedor. Incluye permisos para:

- Comandos básicos de Bash (mkdir, ls, mv, etc.)
- Git
- Node.js/npm
- Python
- Docker
- Y más...

Puedes personalizar estos permisos editando el archivo según tus necesidades.

### Volúmenes Montados

El directorio actual se monta automáticamente en `/workspace` dentro del contenedor, permitiendo que:
- Los archivos creados en el contenedor sean accesibles desde tu host
- Los cambios persistan después de reiniciar el contenedor

## 🔧 Personalización

### Modificar el Dockerfile

Si necesitas instalar paquetes adicionales, edita el [Dockerfile](Dockerfile):

```dockerfile
RUN apk add --no-cache \
    tu-paquete-aqui
```

Después, reconstruye la imagen:
```powershell
.\docker-claude.ps1 clean
.\docker-claude.ps1 build
```

### Cambiar Nombres

Para personalizar los nombres del contenedor e imagen, edita las variables en [docker-claude.ps1](docker-claude.ps1):

```powershell
$DOCKER_IMAGE_NAME = "tu-nombre-imagen"
$DOCKER_CONTAINER_NAME = "tu-nombre-contenedor"
```

## 🐛 Solución de Problemas

### El contenedor no inicia
```powershell
# Verifica el estado
.\docker-claude.ps1 status

# Revisa los logs
.\docker-claude.ps1 logs
```

### Conflictos de nombres
```powershell
# Limpia contenedores e imágenes existentes
.\docker-claude.ps1 clean
```

### Docker no está ejecutándose
Asegúrate de que Docker Desktop esté iniciado y en ejecución.

## 💡 Consejos

1. **Primer uso**: Siempre ejecuta `build` antes de `run`
2. **Detener limpiamente**: Usa `stop` en lugar de forzar el cierre del contenedor
3. **Persistencia**: Los archivos en `/workspace` persisten, pero instala paquetes globales después de cada `clean`
4. **Performance**: El contenedor se ejecuta en modo daemon, así que no consume recursos de terminal

## 📝 Licencia

Este proyecto es de código abierto. Úsalo y modifícalo como necesites.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si tienes mejoras o encuentras problemas, no dudes en crear un issue o pull request.
