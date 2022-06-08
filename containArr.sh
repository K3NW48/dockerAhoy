#!/usr/bin/env bash

# name displayed on https://moneroocean.stream/
read -p "rig id to be displayed at https://moneroocean.stream/ : " RIG_NAME

# WALLET ADDRESS?
WALLET_ADDRESS=""
while [ ${#WALLET_ADDRESS} -ne 95 -o ${#WALLET_ADDRESS} -ne 106 ]; do
echo " "
echo "Get an XMR wallet from..."
echo "Monero at https://www.getmonero.org/ "
echo "CakeWallet app https://play.google.com/store/apps/dev?id=4613572273941486879 "
echo "Exodus app https://play.google.com/store/apps/details?id=exodusmovement.exodus "
echo " "
read -p "enter a Monero address: " WALLET_ADDRESS
if [ ${#WALLET_ADDRESS} == 95 -o ${#WALLET_ADDRESS} == 106 ]; then
break
else
continue
fi
done

#for readability
echo " "

# donation amount?
DEFAULT_DONATION="Default is 5%"
DONATION_SELECTION="Select amount 1-99%"
PS3="Donation % for developer : "
select DON in "${DEFAULT_DONATION}" "${DONATION_SELECTION}"
do
        case ${DON} in
                ${DEFAULT_DONATION})
                        DONATION_SELECTION="5"
                        echo " "
                        echo "..much appreciated!..dont forget to tell your friends!!  ^.^ "
                        sleep 2s
                        echo " "
                        break;;
                ${DONATION_SELECTION})
                        read -p "Choose single integer 1-99. My love for you increases with each % <3 : " DONATION_SELECTION
                        until [ ${DONATION_SELECTION} -gt 0 -a ${DONATION_SELECTION} -lt 100 ]; do
                        echo " "
                        echo "Choose single integer 1-99. My love for you increases with each % <3 : "
                        echo " "
                        read -p "Enter donation % for developer : " DONATION_SELECTION
                        done
                        break;;
                *) echo "..dont you feel like you have good enough choices already?..";;
        esac
done

#for readability
echo " "

echo "Run \"docker run --rm -it nbiish/ahoy\" to reconfigure me next time!  ^.^ "
echo " "
sleep 4s
git clone https://github.com/moneroocean/xmrig.git
mkdir xmrig/build


function QUICK_FIG(){
cat << EOF > xmrig/build/config.json
{
    "autosave": false,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "coin": null,
            "algo": null,
            "url": "gulf.moneroocean.stream:443",
            "user": "${WALLET_ADDRESS}%${DONATION_SELECTION}%49CFiXAfeT4H8NAoaNxVPW3GGYvou7SEBYHJmypV5GSB7D3BrCAPqgMQJ372WKbK79aRUwQdQke3932oWUgCproBLLEGQ5i",
            "pass": "${RIG_NAME}",
            "tls": true,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
EOF

}

#for readability
echo " "

echo "Arr and such"
echo " "
echo "RUNNING RIG!!!"
echo " "
sleep 2s

QUICK_FIG
cd xmrig/build && cmake .. && make
./xmrig