#!/bin/bash
mostrar_login_exitoso() {
    echo "Registros de inicio de sesión exitosos:"
    grep "Accepted" /var/log/auth.log
}
mostrar_login_fallido() {
    echo "Registros de inicio de sesión fallidos:"
    grep "Failed" /var/log/auth.log
}
mostrar_todos_los_logs() {
    echo "Todos los registros de inicio de sesión:"
    cat /var/log/auth.log
}
menu_principal() {
    while true; do
        echo "Seleccione una opción:"
        echo "1. Mostrar registros de inicio de sesión exitosos"
        echo "2. Mostrar registros de inicio de sesión fallidos"
        echo "3. Mostrar todos los registros de inicio de sesión"
        echo "4. Salir"

        read opcion

        case $opcion in
            1)
                mostrar_login_exitoso
                ;;
            2)
                mostrar_login_fallido
                ;;
            3)
                mostrar_todos_los_logs
                ;;
            4)
                exit 0
                ;;
            *)
                echo "Opción no válida. Inténtelo de nuevo."
                ;;
        esac
    done
}

menu_principal
