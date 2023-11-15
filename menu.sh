#!/bin/bash
op=1
echo "AVISO: Si eres un usuario administrador, por favor ingrese a este script como 'root'"
sleep 3
while [[ $op -ne 0 ]]; do
        clear
        sshd_active=$(systemctl is-active sshd)
        echo ------------- Menú Principal -------------
        echo [1] Crear usuarios/grupos
        echo [2] Gestión de logs
        echo [3] Docker
        echo [4] Respaldo
        if [[ $sshd_active == active ]]; then
                echo -e "[5] Desactivar SSH \e[1;32m■ activo \e[0m"
        else
                echo -e "[5] Activar SSH  \e[1;31m■ inactivo \e[0m"
        fi
        echo [6] Firewall
        echo [0] Salir
        echo ------------------------------------------

        read -p "Ingrese una opción: " op

        case $op in
                1)
                        read -p "Ingrese el nombre del usuario: " nomUser
                        read -p "¿Desea elegir un grupo? Y/N | " groupDef
                        if [[ "$groupDef" == "Y" ]];then
                                read -p "Elija el nombre del grupo: " nomGroup
                                if [[ "$nomGroup" == "wheel" ]]; then
                                        useradd -d /home/$nomUser -m -g $nomGroup -G group0,group1 -s /bin/bash $nomUser
                                elif [[ "$nomGroup" == "gdocker" || "$nomGroup" == "gbackups" ]]; then
                                        useradd -d /home/$nomUser -m -g $nomGroup -G group0,group2,docker -s /bin/bash $nomUser
                                else
                                        useradd -d /home/$nomUser -m -g $nomGroup -G group0,group2 -s /bin/bash $nomUser
                                fi
                        else
                                echo Usando grupo predefinido...
                                useradd -d /home/$nomUser -G group0 -s /bin/bash $nomUser
                        fi
                        passwd $nomUser
                        ;;

                2)
                        ./logs.sh
                        ;;

                3)
                        ./docker.sh
                        ;;

                4)
                        ./menu_backup.sh
                        ;;

                5)
                        if [[ $sshd_active == active ]]; then
                                systemctl stop sshd
                        else
                                systemctl start sshd
                        fi
                        echo ok!
                        ;;

                6)
                        ./menu_firewall.sh
                        ;;

                0)
                        clear
                        exit
                        ;;

                *)
                        echo ERROR - OPCION INVÁLIDA
                        op=1
                        ;;
        esac
        read -p "Presione ENTER para continuar..."
done
