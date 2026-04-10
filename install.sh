#!/bin/bash

echo "Will need to update keyring"
read -r -p "Is this okay? [y/N]" response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
        sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg2
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
        sudo dpkg -i cuda-keyring_1.1-1_all.deb
	curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
	&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
	sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
	sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
	sudo apt update
	sudo apt install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	sudo tee /etc/apt/sources.list.d/docker.sources <<-EOF
	Types: deb
	URIs: https://download.docker.com/linux/ubuntu
	Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
	Components: stable
	Architectures: $(dpkg --print-architecture)
	Signed-By: /etc/apt/keyrings/docker.asc
	EOF
else
        echo "These are necessary for installation, Goodbye"
        exit 1
fi

sudo apt-get update

#check for dependencies
declare -a EXP=(
"docker-ce"
"docker-ce-cli"
"containerd.io"
"docker-buildx-plugin"
"docker-compose-plugin"
"cuda-toolkit-12-8"
"docker-compose-plugin"
"nvidia-driver-580-open"
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
#installs latest NVIDIA container toolkit, edit this variable to whatever version may be needed
NVIDIA_CONTAINER_TOOLKIT_VERSION=$(apt-cache policy nvidia-container-toolkit | grep Candidate | awk '{print $2}')
sudo apt-get install -y \
nvidia-container-toolkit=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
nvidia-container-toolkit-base=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
libnvidia-container-tools=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
libnvidia-container1=$NVIDIA_CONTAINER_TOOLKIT_VERSION

echo "Adding user to abeonasec"
sudo useradd -r -s /bin/bash abeonasec
echo "Adding current user to abeonasec group"
sudo usermod -aG abeonasec $USER

sudo mkdir /etc/abeonasec/
sudo mkdir /etc/abeonasec/compose/
sudo mkdir /etc/abeonasec/compose/networks
sudo mkdir /etc/abeonasec/compose/plugins
sudo chown -R abeonasec:abeonasec /etc/abeonasec
sudo chmod -R g+rwxs /etc/abeonasec
sudo mkdir /opt/abeonasec/
sudo mkdir /opt/abeonasec/scripts
sudo mkdir /opt/abeonasec/models
sudo mkdir /opt/abeonasec/certs
sudo mkdir /opt/abeonasec/plugins
sudo chown -R abeonasec:abeonasec /opt/abeonasec
sudo chmod -R g+rwxs /opt/abeonasec
sudo mkdir /var/lib/abeonasec
sudo mkdir /var/lib/abeonasec/data
sudo mkdir /var/lib/abeonasec/kafka
sudo mkdir /var/lib/abeonasec/eleasticsearch
sudo chown -R abeonasec:abeonasec /var/lib/abeonasec
sudo mkdir /var/lib/abeonasec/elasticsearch/data
sudo chown -R 1000:1000 /var/lib/abeonasec/elasticsearch/data
sudo chmod -R g+rwxs /var/lib/abeonasec
sudo mkdir /var/log/abeonasec/
sudo chown -R abeonasec:abeonasec /var/log/abeonasec
sudo chmod -R g+rwxs /var/log/abeonasec

read -s -p "Please enter a password for the configuration: " password

sudo cp -r ./compose /etc/abeonasec/
sudo cp ./conf/es-client.yml /etc/abeonasec/

sed -i "s/placeholder123/$password/g" /etc/abeonasec/es-client.yml

sudo bash -c "echo "ELASTIC_PASSWORD=$password" >> /etc/abeonasec/compose/.env"

sudo docker compose -f /etc/abeonasec/compose/compose.yml pull

echo ""
echo "Please reboot your system"
