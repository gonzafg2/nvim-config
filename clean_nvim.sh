#!/bin/bash
# Script para limpiar completamente la configuración de Neovim y reiniciar

echo "🧹 Limpiando configuración de Neovim..."

# Directorios a limpiar
LAZY_DIR="$HOME/.local/share/nvim/lazy"
CACHE_DIR="$HOME/.cache/nvim"
STATE_DIR="$HOME/.local/state/nvim"

# Hacer backup del directorio lazy (por si acaso)
if [ -d "$LAZY_DIR" ]; then
    echo "📦 Haciendo backup del directorio lazy..."
    mv "$LAZY_DIR" "${LAZY_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Limpiar caché
if [ -d "$CACHE_DIR" ]; then
    echo "🗑️  Limpiando caché..."
    rm -rf "$CACHE_DIR"
fi

# Limpiar state
if [ -d "$STATE_DIR" ]; then
    echo "🗑️  Limpiando state..."
    rm -rf "$STATE_DIR"
fi

# Recrear directorios
echo "📁 Recreando directorios..."
mkdir -p "$CACHE_DIR"
mkdir -p "$STATE_DIR"
mkdir -p "$LAZY_DIR"

echo "✅ Limpieza completa!"
echo ""
echo "Ahora abre Neovim y lazy.nvim se reinstalará automáticamente."
echo "Ejecuta :Lazy sync después de que se cargue."