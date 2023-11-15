#!/bin/bash

opc=0

while [[ $opc -ne 3 ]]; do
        clear
        echo --------- Administración de Docker -----------
        echo [1] "Iniciar servicios (compose)."
        echo [2] Editar archivo.
        echo [3] Salir.
        echo ----------------------------------------------
        echo
        read -p "Seleccione una opción: " opc

        case $opc in
                1)clear
                        echo "Ejecutando servicios..."
                        sleep 1
                        docker compose -f /home/proyecto/megainc/compose.yaml up -d
                        ;;
                2)clear
                        vim /home/proyecto/megainc/compose.yaml
                        ;;

                3) clear
                        exit
                        ;;

                *)
                        echo "Opción inválida. Reiniciando... "
                        ;;
        esac
        read -p "Presione ENTER para continuar"
done