#!/bin/bash

echo "Beginning Abeonasec install"

if [ ! -d "/opt/abeonasec" ]; then
	sudo mkdir /opt/abeonasec
fi

#check for necessary commands
if ! command -v git >/dev/null 2>&1
then
	echo "git could not be found"
	exit 1
fi

if ! command -v docker >/dev/null 2>&1
then
	echo "docker could not be found"
	read -r -p "Would you like to install docker? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		sudo apt-get install -y ca-certificates curl
		sudo install -m 0755 -d /etc/apt/keyrings
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
		sudo chmod a+r /etc/apt/keyrings/docker.asc
		sudo tee /etc/apt/sources.list.d/docker.sources <<-EOF
		Types: deb
		URIs: https://download.docker.com/linux/ubuntu
		Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
		Components: stable
		Signed-By: /etc/apt/keyrings/docker.asc
		EOF
		sudo apt-get update
		sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
		echo "docker installation complete"
	else
		echo "Docker is necessary for this installation"
		exit 1
	fi
fi

if ! command -v conda >/dev/null 2>&1
then
	echo "conda could not be found"
	read -r -p "Would you like to install miniconda? [y/N] " response
	if [[ "@&response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		mkdir -p ~/miniconda3
		wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
		bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
		rm ~/miniconda3/miniconda.sh

		source ~/miniconda3/bin/activate

		conda init --all
	else
		echo "Conda is necessary for this installation"
		exit 1
	fi
fi

if [ ! -d "/home/$USER/miniconda3/envs/morpheus" ]; then
	echo  "Installing Morpheus to conda"

	export CONDA_ENV_NAME=morpheus
	conda create -n ${CONDA_ENV_NAME} python=3.12
	conda activate ${CONDA_ENV_NAME}

	conda config --env --add channels conda-forge &&\
	  conda config --env --add channels nvidia &&\
	  conda config --env --add channels rapidsai &&\
	  conda config --env --add channels pytorch

	conda install -c nvidia morpheus-core=25.06


	MORPHEUS_CORE_PKG_DIR=$(dirname $(python -c "import morpheus; print(morpheus.__file__)"))
	pip install -r ${MORPHEUS_CORE_PKG_DIR}/requirements_morpheus_core_arch-$(arch).txt
fi
echo "Pulling Triton docker container"

sudo docker pull nvcr.io/nvidia/morpheus/morpheus-tritonserver-models:25.06
