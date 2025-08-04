#!/bin/zsh
# Configuración programática de SSH Agent para macOS

# Función para cargar todas las llaves SSH al agente
load_ssh_keys() {
    local ssh_dir="$HOME/.ssh"
    local loaded_count=0
    
    # Verificar si el directorio SSH existe
    [[ ! -d "$ssh_dir" ]] && return 1
    
    # Iterar sobre todos los archivos en ~/.ssh
    for key_file in "$ssh_dir"/id_*; do
        # Saltar archivos .pub y otros que no sean llaves privadas
        [[ "$key_file" =~ \.pub$ ]] && continue
        [[ ! -f "$key_file" ]] && continue
        
        # Verificar que sea una llave privada válida
        if grep -q "PRIVATE KEY" "$key_file" 2>/dev/null; then
            # Intentar agregar la llave al agente
            if ssh-add --apple-use-keychain "$key_file" 2>/dev/null; then
                ((loaded_count++))
            fi
        fi
    done
    
    # Mensaje opcional de depuración (comentar en producción)
    # echo "SSH Agent: $loaded_count llaves cargadas"
    
    return 0
}

# Configuración del SSH Agent
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Verificar si ssh-agent está corriendo
    if ! ssh-add -l &>/dev/null; then
        # Si no hay agente o no hay llaves, cargar todas las llaves
        load_ssh_keys
    fi
    
    # Alternativamente, si prefieres SIEMPRE recargar las llaves al iniciar:
    # load_ssh_keys
fi

# Exportar la función para uso manual si es necesario (solo en bash)
# export -f load_ssh_keys 2>/dev/null || true