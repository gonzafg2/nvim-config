# Fix para SSH Agent en Neovim

## El Problema

Neovim no está heredando el ssh-agent, lo que impide hacer pull/push desde vim-fugitive o plugins similares. El ssh-agent tiene variables de entorno configuradas pero no hay identidades cargadas.

## Diagnóstico Actual

- **SSH_AUTH_SOCK**: `/private/tmp/com.apple.launchd.7xn53ghmug/Listeners`
- **Shell**: `/bin/zsh`
- **Identidades SSH**: No hay identidades cargadas en el agente
- **Llaves disponibles**: 6 llaves SSH públicas en `~/.ssh/`

## Soluciones

### 1. Configurar ssh-agent en ~/.zshrc

Agrega esto a tu `~/.zshrc`:

```bash
# Iniciar ssh-agent si no está corriendo
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# En macOS, usar el keychain del sistema
# Esto carga TODAS tus llaves SSH al agente
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Opción 1: Cargar llaves específicas
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || \
    ssh-add --apple-use-keychain ~/.ssh/id_rsa 2>/dev/null
    
    # Opción 2: Cargar TODAS las llaves privadas (sin .pub)
    # for key in ~/.ssh/id_*; do
    #     [[ ! "$key" =~ \.pub$ ]] && ssh-add --apple-use-keychain "$key" 2>/dev/null
    # done
fi
```

### 2. Configuración específica para macOS Keychain

**IMPORTANTE**: Si ya tienes configuraciones específicas por Host (como `Host vps-central`, `Host github.com`, etc.), 
la configuración `Host *` NO las sobrescribe. SSH usa la primera coincidencia más específica.

Agrega AL FINAL de tu `~/.ssh/config`:

```
# Configuración por defecto para hosts no especificados
Host *
  AddKeysToAgent yes
  UseKeychain yes
```

O si prefieres ser más específico para Git:

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519_github

Host gitlab.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519_gitlab

Host bitbucket.org
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519_bitbucket
```

### 3. Script de inicialización para Neovim

Crea un wrapper script en `~/bin/nvim-ssh`:

```bash
#!/bin/zsh
# Asegurar que ssh-agent esté disponible
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# Cargar llaves si no están cargadas
if ! ssh-add -l &>/dev/null; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || \
    ssh-add --apple-use-keychain ~/.ssh/id_rsa 2>/dev/null
fi

# Lanzar Neovim con las variables de entorno correctas
exec /opt/homebrew/bin/nvim "$@"
```

Luego: `chmod +x ~/bin/nvim-ssh` y usa `alias nvim='nvim-ssh'` en tu `.zshrc`.

### 4. Solución temporal (inmediata)

Ejecuta antes de abrir Neovim:

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
# o la llave que uses para Git
```

### 5. Usar Terminal dentro de Neovim

Como workaround, usa `:terminal` dentro de Neovim para operaciones Git:

```vim
:terminal
git push
```

### 6. Configurar Git Credential Helper

Para HTTPS (alternativa a SSH):

```bash
git config --global credential.helper osxkeychain
```

## Verificación

Después de aplicar las soluciones:

1. Reinicia tu terminal
2. Ejecuta `ssh-add -l` - deberías ver tus llaves
3. Abre Neovim y prueba `:Git push`

## Debug

Si sigue sin funcionar, en Neovim ejecuta:

```vim
:echo $SSH_AUTH_SOCK
:!ssh-add -l
```

Para ver si las variables se están pasando correctamente.