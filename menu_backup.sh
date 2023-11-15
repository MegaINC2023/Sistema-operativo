#!/bin/bash

opc=10
while [ $opc -ne 0 ]; do
        clear
        echo   "-------------- Administracion de Backups --------------"
        echo "[1] Realizar un respaldo ahora"
        echo "[2] Revisar la lista de respaldos"
        if [[ "$USER" == "backup" || "$USER" == "root" ]]; then
                echo -e "\e[1;32m[3] Cambiar la rutina de respaldo y sincronizacion \e[0m"
        else
                echo -e "\e[1;31m[3] Cambiar la rutina de respaldo y sincronizacion\e[0m"
        fi
        echo "[4] Buscar un respaldo"
        echo "[5] Sincronizar los respaldos"
        echo "[0] Salir"
        echo -e "----------------------------------------------------\n"
        read -p "Ingrese una opcion: " opc
        clear
        case $opc in
                1)
                        /home/proyecto/scripts_server/backup.sh
                        echo -e "Respaldo realizado correctamente!\n"
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                2)
                        tree -i -u -d /home/proyecto/backups/ | less
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                3)
                        if [ "$USER" == "backup" ]; then
                                crontab -e
                        elif [ "$USER" == "root" ]; then
                                crontab -e -u  pbackup
                        else
                                echo -e "Lamentablemente, usted no puede hacer eso. Debe ser el usuario backup principal (pbackup) o root para poder modificar la rutina de respaldo\n"
                        fi
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                4)
                        read -p  "Ingrese el nombre del backup a buscar: " bsq
                        clear
                        find /home/proyecto/backups -name "*$bsq*" | less
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                5)
                        read -p "Ingrese la ip del adaptador de Ethernet conectado al servidor: " ips
                        read -p "Ingrese el nombre de usuario de su sistema Windows: " usern
                        read -p "Ingrese su contraseña: " passw
                        read -p "Ingrese el directorio de respaldo remoto ubicado en su escritorio de Windows: " dirct
                        mount -t cifs //$ips/$dirct /home/sisgran/respaldo_remoto -o username=$usern,password=$passw
                        cd /home/sisgran
                        rsync -rav respaldo_remoto/ /home/megainc/backups/
                        umount //$ips/$dirct
                        read -p "Ingrese un boton para continuar: " boton
                        ;;
                *)
                        ;;
        esac
done
clear
