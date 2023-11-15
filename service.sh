#!/bin/bash

clear
opc=10
while [ $opc -ne 0 ]; do
        clear
        echo "1) Activar Servicio"
        echo "2) Desactivar Servicio"
        echo "0) Salir"
        read -p "Elija una opcion: " opc
        case $opc in
                1)
                        read -p "Ingrese el nombre del servicio a activar: " as
                        firewall-cmd --add-service=$as
                        ;;
                2)
                        read -p "Ingrese el nombre del servicio a cerrar: " ds
                        firewall-cmd --remove-service=$ds
                        ;;
                *)
                        ;;
        esac
done
