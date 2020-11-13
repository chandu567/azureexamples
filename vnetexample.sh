

#!/bin/bash
 
 echo "vnetlab.sh"
 echo "1.create resource group red-rg"
 az group create -l eastus -n RED-RG
 
 echo "2.created vnet red-rg-vnet1 location:eastus && one subnet 10 range" 
 az network vnet create -g RED-RG -n RED-RG-vNET1 --address-prefix 10.1.0.0/16 \
 --subnet-name RED-RG-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus
 
echo "3. network nsg"
az network nsg create -g RED-RG -n RED-RG_NSG1 

 echo "4. nsg rule RED-RG"
az network nsg rule create -g RED-RG --nsg-name RED-RG_NSG1 -n RED-RG_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'  --destination-address-prefixes '*' \
 --destination-port-ranges '*' --access Allow  --protocol Tcp --description "Allowing All Traffic For Now"

echo "5.availability-set RED-RG EAST-AVSET1"
az vm availability-set create --name EAST-AVSET1 -g RED-RG --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

echo "6.Creating Azure VM"
az vm create --resource-group RED-RG --name RED-RGTestVM1 --image UbuntuLTS --vnet-name RED-RG-vNET1 \
--subnet RED-RG-Subnet-1 --admin-username chandra --admin-password "chandrashekhar@1234" --size Standard_B1s \
--availability-set EAST-AVSET1 --nsg RED-RG_NSG1
 
echo "7. create resource group orange-rg"
az group create -l eastus -n ORANGE-RG

echo "8.created vnet ORANGE-RG-vnet2 location:eastus && one subnet 172 range" 
az network vnet create -g ORANGE-RG -n ORANGE-RG-vNET1 --address-prefix 172.168.0.0/16 \
--subnet-name ORANGE-RG-Subnet-1 --subnet-prefix 172.168.1.0/24 -l eastus
 
echo "9. network nsg ORANGE-RG"
az network nsg create -g ORANGE-RG -n ORANGE-RG_NSG1  

echo "10.network nsg rule create -g ORANGE-RG "
az network nsg rule create -g ORANGE-RG --nsg-name ORANGE-RG_NSG1 -n ORANGE-RG_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'  --destination-address-prefixes '*' \
--destination-port-ranges '*' --access Allow  --protocol Tcp --description "Allowing All Traffic For Now"
 
echo "11.availability-set create --name EAST-AVSET1"
az vm availability-set create --name EAST-AVSET1 -g ORANGE-RG --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5
 
echo "12.Creating Azure VM"
az vm create --resource-group ORANGE-RG --name ORANGE-RGTestVM1 --image UbuntuLTS --vnet-name ORANGE-RG-vNET1 \
--subnet ORANGE-RG-Subnet-1 --admin-username chandra --admin-password "chandrashekhar@1234" --size Standard_B1s \
--availability-set EAST-AVSET1 --nsg ORANGE-RG_NSG1

 echo "13.create resource group BLUE-rg"
 az group create -l westus -n BLUE-RG
 
 echo "14.created vnet BLUE-rg-vnet1 location:westus && one subnet 10 range" 
 az network vnet create -g BLUE-RG -n BLUE-RG-vNET1 --address-prefix 192.168.0.0/16 \
 --subnet-name BLUE-RG-Subnet-1 --subnet-prefix 192.168.1.0/24 -l westus
 
echo "15. network nsg"
az network nsg create -g BLUE-RG -n BLUE-RG_NSG1 

 echo "16. nsg rule BLUE-RG"
az network nsg rule create -g BLUE-RG --nsg-name BLUE-RG_NSG1 -n BLUE-RG_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'  --destination-address-prefixes '*' \
 --destination-port-ranges '*' --access Allow  --protocol Tcp --description "Allowing All Traffic For Now"

echo "17.availability-set BLUE-RG EAST-AVSET1"
az vm availability-set create --name EAST-AVSET1 -g BLUE-RG --location westus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

echo "18. vm3 machine"
az vm create --resource-group BLUE-RG -- name BLUE-RGTestVM1 --image UbuntuLTS --vnet-name BLUE-RG-VNET1 \
--subnet BLUE-RG-Subnet-1 --admin-username testuser --admin-password "india@123456" --size Standard_B1s \
-- availability-set EAST-AVSET1 -nsg BLUE-RG_NSG1
