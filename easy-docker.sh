#!/bin/bash
## GLOBAL VARS
#ID (TAKE ID OF ALL THE ELEMENTS)
containers_id=$(docker container ls -aq) 
images_id=$(docker images -q)
networks_id=$(docker network ls -q)
volumes_id=$(docker volume ls -q)

##FUNCTIONS
#VERSION OF THE SCRIPT
printVersion(){
        echo "                                                                                    "
        echo "███████╗ █████╗ ███████╗██╗   ██╗     ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ "
        echo "██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝     ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗"
        echo "█████╗  ███████║███████╗ ╚████╔╝█████╗██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝"
        echo "██╔══╝  ██╔══██║╚════██║  ╚██╔╝ ╚════╝██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗"
        echo "███████╗██║  ██║███████║   ██║        ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║"
        echo "╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
        echo "                                                                                       "
        echo "Author: Morfe0"
        echo ""
        echo "Current version: 0.4.1"
        echo ""
        echo "This script provides a faster and easier way to interact with Docker, enjoy it and have a nice deployment!"
}

# HELP FUNCTION
help()
{
        echo "Usage: easy-docker [OPTIONS]"
        echo ""
        echo "This script provides a faster and easier way to interact with Docker, enjoy it and have a nice deployment!"
        echo ""
        echo "Options:"
        echo ""
        echo " -h,     --help                                                          Print Help."
	echo " -D      --deleteAll [-y] 					         Delete all the docker elements, [-y] to dont ask confirmation"
	echo " -l      --list						                 List all the docker elements"
        echo " -rm     --remove [container|image|network|volume] ELEMENTID             Delete specific element"
        echo " -c      --compose [up|down|kill]                                        Docker-compose management on the current directory"
        echo " -v(-V)  --version                                                       Print current version."
	echo " -s      --search [IMAGE_NAME]						 Search on Docker Hub coincidences from this pattern"
}

#DOCKER-COMPOSE MENU FUNCTION
composeMenu(){                          
        echo "Available Options:"
        echo "-----------------"
        echo "- 1. Up"
        echo "- 2. Down"
        echo "- 3. Kill"
        echo "- 4. Back"
        echo ""
        echo -n "What you want to do: "
        read task2
        case $task2 in
        1)
                echo "----------------------"
                echo -n "up docker-compose as daemon? (y/n)"
                read daemonize
                if [ $daemonize = "y" ]
                then
                echo "-------------------------------------------------------------"
                docker-compose up -d
                elif [ $choice1 = "n" ]
                then
                        exit
                else
                        echo "Wrong choice (y/n)"
                        deleteAll
                fi

        ;;
        2)
                docker-compose down
        ;;
        3)
                docker-compose kill
        ;;
        4)
                mainMenu
        ;;
        esac
}

#FUNCTION TO LIST ALL ELEMENTS
listAll(){
        echo " -- CONTAINERS ---------------------------------------------------------------------------"
                docker container ls -as
        echo ""
        echo " -- IMAGES -------------------------------------------------------------------------------"
        	docker image ls -a
        echo ""
        echo " -- NETWORKS -----------------------------------------------------------------------------"
                docker network ls
        echo ""
        echo " -- VOLUMES ------------------------------------------------------------------------------"
                docker volume ls
}

#FUNCTION TO DELETE ALL, ASK CONFIRMATION
deleteAll(){
        echo -n "You try to delete ALL DOCKER ELEMENTS, are you sure? (y/n): "
        read choice1
        if [ $choice1 = "y" ]
        then
                echo "-------------------------------------------------------------"
                docker container stop $containers_id
                docker container rm $containers_id
                docker image rm $images_id
                docker network rm $networks_id
                docker volume rm $volumes_id
        elif [ $choice1 = "n" ]
        then
                exit
        else
                echo "Wrong choice (y/n)"
                deleteAll
        fi
}

#FUNCTION TO DELETE ALL, WITHOUT CONFIRMATION
deleteAllY(){
        docker container stop $containers_id
        docker container rm $containers_id
        docker image rm $images_id
        docker network rm $networks_id
        docker volume rm $volumes_id
}

searchImage(){
	echo -n "What image name are you looking for?: "
	read imageN
	#IDEA IS TO TAKE FIRTS 10 IMGES
	firefox https://hub.docker.com/search?q=$imageN
}

#MAIN MENU FUNCTION
mainMenu(){
        echo "                                                                                    "
        echo "███████╗ █████╗ ███████╗██╗   ██╗     ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ "
        echo "██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝     ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗"
        echo "█████╗  ███████║███████╗ ╚████╔╝█████╗██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝"
        echo "██╔══╝  ██╔══██║╚════██║  ╚██╔╝ ╚════╝██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗"
        echo "███████╗██║  ██║███████║   ██║        ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║"
        echo "╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
        echo "                                                                                       "
        echo "Author: Morfe0"
        echo ""
        echo "Available Options:"
        echo "-----------------"
        echo "- 1. Delete"
        echo "- 2. List"
        echo "- 3. Help"
        echo "- 4. Compose Menu"
        echo "- 5. Search Image"
	echo "- 6. Exit"
        echo ""
        echo "This script support some commands. Push 3 or exec the script with -h/--help to know more"
        echo ""
        echo -n "What you want to do: "
        read task
        echo "-----------------------"
        case $task in #CHECK OPTION SELECTED
        #DELETE OPTIONS
        1)
                echo "Available Delete Options:"
                echo "------------------------"
                echo "1. All"
                echo "2. Containers"
                echo "3. Images"
                echo "4. Networks"
                echo "5. Volumes"
                echo "6. Back"
                echo ""
                echo -n "What you want to do: "
                read delete_what
                case $delete_what in #CHECK WHAT YOU WANT TO DELETE
                        1)
                                deleteAll
                        ;;
                        2)
                                docker container ls -as #FIRTS LIST TO MAKE EASIER
                                echo ""
                                echo -n "Container ID: "
                                read delete_that_container
                                docker container stop $delete_that_container
                                docker container rm $delete_that_container
                        ;;
                        3)
                        	docker image ls -a #FIRTS LIST TO MAKE EASIER
                                echo ""
                                echo -n "Image ID: "
                                read delete_that_img
                                docker rmi $delete_that_img

                        ;;
                        4)
                                docker network ls #FIRTS LIST TO MAKE EASIER
                                echo ""
                                echo -n "Network ID: "
                                read delete_that_net
                                docker network rm $delete_that_net
                        ;;
                        5)
                                docker volume ls #FIRTS LIST TO MAKE EASIER
                                echo ""
                                echo -n "Volume ID: "
                                read delete_that_vol
                                docker volume rm $delete_that_vol
                        ;;
			6)
                                mainMenu #BACK
                        ;;
                esac
        ;;
        #LIST ALL DOCKER ELEMENTS
        2)
                listAll
                
        ;;
        #DISPLAY HELP INFO
        3)
                help
        ;;
        #DOCKER-COMPOSE MENU
        4)
                composeMenu
        ;;
        5)
		searchImage
	;;
	#EXIT
        6)
                exit
        ;;
esac
}

##SCRIPT START HERE
if [ -z $1 ] #CHECK IF $1 EXIST
then
# INTERFACE MODE
mainMenu
else
# COMMAND MODE
while [ $# -gt 0 ]    #WHILE ALL PARAMETERS ARE > TO 0
do
case $1 in 
        -v|-V|--version)
                printVersion
        ;;
	-h|--help)
		help
	;;
	-D|--deleteAll)
                if [ -z $2 ] #CHECK IF $2 EXIST IF DONT EXEC DELETEALL FUNCTION IF EXIST EXEC DELETEALLY (DELETE ALL WITHOUT CONFIRMATION)
                then
                        deleteAll
                elif [ $2 = "-y" ]
                then
                        deleteAllY
                        shift #SHIFT BECAUSE IF DONT -y PARAMETER WILL BE CHECKED 2 TIMES AND THE SECOND DISPLAY BAD OPTION MENSSAGE BECAUSE THIS OPTION ONLY EXIST ON -D
                fi
	;;
	-l|--list)
		listAll
	;;
        -rm|--remove)
                if [ -z $2 ]
                then
                        echo "Define action required"
                else
                        if [ -z $3 ]
                        then
                                echo "Define element id required"
                        else
                                if [ $2 = "container" ]
                                then
                                        docker container stop $3
                                        docker $2 rm $3
                                elif [ $2 = "image" ]
                                then
                                        docker image rm $3
                                elif [ $2 = "volume" ]
                                then
                                        docker volume rm $3
                                elif [ $2 = "network" ]
                                then
                                        docker network rm $3
                                else
                                        echo "Are you trying to do something nasty homie?"
                                        exit
                                fi
                        fi
                fi
                exit
        ;;
        -c|--compose)
                if [ -z $2 ]
                then
                      echo "Define action required"
                else
                        case $2 in
                                up)
                                if [ -z $3 ]
                                then
                                        docker-compose up
                                elif [ $3 = "-d" ]
                                then
                                        docker-compose up -d
                                        exit
                                else
                                        echo "Wrong option"
                                        exit
                                fi
                                ;;
                                down)
                                        docker-compose down
                                        exit
                                ;;
                                kill)
                                        docker-compose kill
                                        exit
                                ;;
                                *)
                                        echo "This option is not available"
                                        exit
                                ;;
                        esac
                fi
                exit
        ;;
	-s|--search)
	firefox https://hub.docker.com/search?q=$2
        shift
	;;
        *)
                echo "This option is not available"
                help
        ;;
esac
shift #$2 NOW IS $1
done
fi

