
while true; do
    clear
    echo "===== Menu ====="
    echo "0. Introduction"
    echo "1. ANSSI Hardware Hardening Script"
    echo "2. ANSSI Kernel Configuration Hardening Script"
    echo "3. ANSSI Disk Partition Hardening Script"
    echo "4. ANSSI Authentication and Identification Hardening Script"
    echo "5. ANSSI File Protection Hardening Script"
    echo "6. ANSSI Network Hardening Script"
        
    echo "7. Exit"
    echo "================"

    read -p "Enter your choice: " choice

    case $choice in
    	0)
    	    echo "Introduction"
    	    echo "LINUX HARDENING AUTOMATION SCRIPT"
	    echo "Made by OUTAIK Youness & LAANIBI Walid"
	    echo "Under the supervision of teacher ACHBAROU Omar"
    	    ;;
        1)
            echo "1. ANSSI Hardware Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L1.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        2)
            echo "2. ANSSI Kernel Configuration Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L2.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        3)
            echo "3. ANSSI Disk Partition Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L3.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        4)
            echo "4. ANSSI Authentication and Identification Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L4.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        5)
            echo "5. ANSSI File Protection Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L5.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        6)
            echo "6. ANSSI Network Hardening Script"
            # Prompt the user
	    read -p "Do you want to execute the bash script? (yes/no): " answer
	    # Check the user's response
	    if [[ "$answer" == "yes" ]]; then
	    echo "Executing the script..."
	    	sudo ./L6.sh
	    elif [[ "$answer" == "no" ]]; then
	    	echo "Not executing the script."
	    else
	    	echo "Invalid input. Please enter 'yes' or 'no'."
	    fi
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 7."
            ;;
    esac

    read -n 1 -s -r -p "Press any key to continue..."
done


