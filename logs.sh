#!/bin/bash

opc=0

while [[ $opc -ne 6 ]]; do
        clear
        echo ------Gestión de Logs--------
        echo [1] Ultimo arranque.
        echo [2] Lista de arranques.
        echo [3] Ultimo inicio de sesión.
        echo [4] Conexiones mediante SSH.
        echo [5] Conexiones fallidas.
        echo [6] Volver atras.
        echo -----------------------------
        echo
        read -p "Seleccione una opción: " opc

        case $opc in
                1)clear
                        echo Mostrando información del arranque del ultimo arranque...
                        journalctl -b -1
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                2)clear
                        journalctl --list-boot
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                3)clear
                        echo -e "\e[1m-- Últimos inicios de sesión --\e[0m"
                        lastlog --user 0 && lastlog --user 1000- | egrep -v "Username\s*Port"
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                4)clear
                        echo -e "\e[1m-- Conexiones SSH --\e[0m"
                        journalctl -t sshd --grep="(:?session opened)|(:?Accepted password)"
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                5)clear
                        journalctl --unit=sshd.service --grep="(:?authentication failure)|(:?Failed password)"
                        #journalctl --unit=sshd.service | egrep --color=always -i "(:?authentication failure)|(:?Failed password)" | less -r
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                6)clear
                        ;;
                *)
                        echo "Opción inválida"
                        ;;
        esac
done
