#!/bin/bash

mostrar_menu_principal() {
    clear
    echo "### Centro de Cómputo - Operador ###"
    echo "1. Ver estado del servidor"
    echo "2. Reiniciar servidor"
    echo "3. Apagar servidor"
    echo "4. Ver registros de inicio de sesión"
    echo "5. Crear usuario"
    echo "6. Eliminar usuario"
    echo "7. Modificar usuario"
    echo "8. Crear grupo"
    echo "9. Eliminar grupo"
    echo "10. Salir"
}

crear_usuario() {
    read -p "Nombre del nuevo usuario: " nombre_usuario
    read -p "Cédula del nuevo usuario: " cedula
    read -p "Grupo al que pertenece (deje en blanco para crear un usuario sin grupo): " grupo

    if [ -z "$grupo" ]; then
        sudo useradd -m -s /bin/bash -c "Cédula: $cedula" "$nombre_usuario"
    else
        sudo useradd -m -s /bin/bash -c "Cédula: $cedula" -G "$grupo" "$nombre_usuario"
    fi

    echo "Usuario $nombre_usuario creado correctamente."
}

# Función para eliminar un usuario
eliminar_usuario() {
    read -p "Nombre de usuario a eliminar: " nombre_usuario
    sudo userdel -r "$nombre_usuario"
    echo "Usuario $nombre_usuario eliminado correctamente."
}

# Función para modificar un usuario
modificar_usuario() {
    read -p "Nombre de usuario a modificar: " nombre_usuario
    read -p "Nuevo nombre de usuario (deje en blanco para mantener el actual): " nuevo_nombre_usuario
    read -p "Nueva cédula (deje en blanco para mantener la actual): " nueva_cedula
    read -p "Nuevo grupo (deje en blanco para mantener el actual): " nuevo_grupo

    parametros_modificacion=""

    if [ -n "$nuevo_nombre_usuario" ]; then
        parametros_modificacion="$parametros_modificacion -l $nuevo_nombre_usuario"
    fi

    if [ -n "$nueva_cedula" ]; then
        parametros_modificacion="$parametros_modificacion -c 'Cédula: $nueva_cedula'"
    fi

    if [ -n "$nuevo_grupo" ]; then
        parametros_modificacion="$parametros_modificacion -g $nuevo_grupo"
    fi

    sudo usermod $parametros_modificacion "$nombre_usuario"
    echo "Usuario $nombre_usuario modificado correctamente."
}

# Función para crear un grupo
crear_grupo() {
    read -p "Nombre del nuevo grupo: " nombre_grupo
    sudo groupadd "$nombre_grupo"
    echo "Grupo $nombre_grupo creado correctamente."
}

# Función para eliminar un grupo
eliminar_grupo() {
    read -p "Nombre del grupo a eliminar: " nombre_grupo
    sudo groupdel "$nombre_grupo"
    echo "Grupo $nombre_grupo eliminado correctamente."
}