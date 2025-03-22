#!/bin/bash

LOG_FILE="/var/log/pifi_attack_log.txt"

# Function to log attacks
log_attack() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE" > /dev/null
}

# Check for dependencies
check_dependencies() {
    dependencies=("aircrack-ng" "wifite" "reaver" "bully" "bettercap" "macchanger" "hcxtools" "hashcat" "john" "hydra" "kismet" "ettercap" "dnsmasq" "sslstrip" "airodump-ng")
    missing_tools=()

    for tool in "${dependencies[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done

    if [ ${#missing_tools[@]} -ne 0 ]; then
        echo "❌ Missing dependencies: ${missing_tools[*]}"
        echo "Would you like to install them now? (y/n)"
        read -r install_choice
        if [[ "$install_choice" == "y" ]]; then
            echo "Installing missing tools..."
            sudo apt install -y "${missing_tools[@]}"
        else
            echo "⚠️ Skipping installation. Some features may not work properly."
        fi
    else
        echo "✅ All dependencies are installed!"
    fi
}

# Display Pi-Fi Banner with Animation
pi_fi_banner() {
    clear
    echo "🚀 Starting Pi-Fi..."
    sleep 1
    echo -e "\e[92m██████╗ ██╗        ██╗███████╗"
    echo -e "\e[92m██╔══██╗██║        ██╔██╔════╝"
    echo -e "\e[92m██████╔╝██║███████╗██║█████╗  "
    echo -e "\e[92m██╔═══╝ ██║╚══════ ██║██╔══╝  "
    echo -e "\e[92m██║     ██║        ██║██"
    echo -e "\e[92m╚═╝     ╚═╝           ╚══════╝\e[0m"
    echo -e "\e[93mDeveloped by @penielmelaku\e[0m"
    echo ""
    echo "Initializing system..."
    sleep 1

    # Startup Animation
    for i in {1..3}; do
        clear
        echo "🚀 Loading Pi-Fi ."
        sleep 0.5
        clear
        echo "🚀 Loading Pi-Fi .."
        sleep 0.5
        clear
        echo "🚀 Loading Pi-Fi ..."
        sleep 0.5
        clear
    done

    # Pi Symbol Banner
    echo -e "\e[93m"
    echo "        ππππππππππππππ  "
    echo "      ππππππππππππππππππ  "
    echo "    πππππππππππππππππππππ  "
    echo "   ππππππππ   Pi-Fi   ππππππππ  "
    echo "  ππππππππππππππππππππππππ  "
    echo "   ππππππππππππππππππππ  "
    echo "     ππππππππππππππππ  "
    echo -e "\e[0m"
    sleep 1

    # UFO Animation
    for i in {1..5}; do
        echo "   ☄️   ☄️   🛸   ☄️   ☄️   "
        sleep 0.2
        clear
        echo " ☄️   ☄️   🛸   ☄️   ☄️   "
        sleep 0.2
        clear
    done
    echo "🚀 Welcome to Pi-Fi!"
    sleep 1
}

# Main Menu
main_menu() {
    while true; do
        clear
        pi_fi_banner
        echo -e "\e[96m[1] Enable Monitor Mode"
        echo -e "[2] Disable Monitor Mode"
        echo -e "[3] Scan WiFi Networks"
        echo -e "[4] Capture Handshake & Crack WPA"
        echo -e "[5] Evil Twin Attack"
        echo -e "[6] WPS PIN Crack (Reaver/Bully)"
        echo -e "[7] Bluetooth Attacks"
        echo -e "[8] MITM & Sniffing (Bettercap)"
        echo -e "[9] Enable Stealth Mode"
        echo -e "[10] AI Auto Attack"
        echo -e "[11] Exit\e[0m"
        echo -n "Select an option: "
        read -r option

        case $option in
            1) enable_monitor_mode ;;
            2) disable_monitor_mode ;;
            3) scan_wifi ;;
            4) capture_handshake ;;
            5) evil_twin_attack ;;
            6) wps_pin_crack ;;
            7) bluetooth_attack ;;
            8) mitm_attack ;;
            9) enable_stealth_mode ;;
            10) auto_attack ;;
            11) exit ;;
            *) echo "Invalid option, try again." ;;
        esac
        sleep 2
    done
}

# Start the script
check_dependencies
main_menu
