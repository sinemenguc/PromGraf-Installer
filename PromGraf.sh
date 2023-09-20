#!/bin/bash

#Docker ve Docker Compose'un indirileceği dizin
install_dir="/usr/local/bin"

#Docker'ı yükle
if ! command -v docker &> /dev/null; then
  echo "Docker yükleniyor..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  rm get-docker.sh
  echo "Docker başarıyla yüklendi."
else
  echo "Docker zaten yüklü."
fi

#Docker Compose'u yükle
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose yükleniyor..."
  latest_compose_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep "tag_name" | cut -d'"' -f4)
  sudo curl -L "https://github.com/docker/compose/releases/download/${latest_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o "${install_dir}/docker-compose"
  sudo chmod +x "${install_dir}/docker-compose"
  echo "Docker Compose başarıyla yüklendi. Sürüm: ${latest_compose_version}"
else
  echo "Docker Compose zaten yüklü."
fi
