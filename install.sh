#!/bin/bash

sudo apt-get update && sudo apt-get upgrade

sudo ubuntu-drivers autoinstall

sudo useradd -r -s /bin/bash abeonasec

#check for dependencies
declare -a EXP=(
"ca-certificates"
"curl"
"gnupg2"
"podman"
)
declare -a DEP=(

)

for i in ${EXP[@]}
do
	if ! dpkg -s $i >/dev/null 2>&1
	then
		DEP+=($i)
	fi
done

if (( ${#DEP[@]} ));
then
	echo "The following will be installed with apt:"
	echo "${DEP[@]}"
	read -r -p "Is this okay? [y/N]" response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		sudo apt-get install -y "${DEP[@]}"
	else
		echo "These are necessary for installation, Goodbye"
		exit 1
	fi
fi

echo "Installing nvidia container toolkit"
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.2-1
sudo apt-get install -y \
nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}

sudo mkdir /etc/abeonasec/
sudo mkdir /opt/abeonasec/
sudo mkdir /opt/abeonasec/scripts
sudo mkdir /opt/abeonasec/models
sudo mkdir /var/lib/abeonasec/data
sudo mkdir /var/log/abeonasec/

echo "Please reboot your system"
