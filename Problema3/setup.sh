#!/usr/bin/env bash
set -euo pipefail

echo "==> Actualizando índices APT..."
sudo apt-get update -y

need_cmd() { command -v "$1" >/dev/null 2>&1; }

echo "==> Instalando Python + pip"
sudo apt-get install -y python3 python3-pip python3-venv

echo "==> Instalando R"
sudo apt-get install -y r-base

echo "==> Instalando Ruby"
sudo apt-get install -y ruby-full

echo "==> Instalando Node.js y npm"
if ! need_cmd node; then
  sudo apt-get install -y nodejs npm
fi

echo "==> Instalando .NET SDK (C#) si no está presente"
if ! need_cmd dotnet; then
  sudo apt-get install -y wget apt-transport-https gpg
  wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb || \
  wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
  sudo dpkg -i /tmp/packages-microsoft-prod.deb
  sudo apt-get update -y
  sudo apt-get install -y dotnet-sdk-8.0
fi

echo "==> Creando venv de Python y agregando NumPy"
python3 -m venv .venv-p3 || true
. .venv-p3/bin/activate
pip install --upgrade pip
pip install numpy
deactivate

echo "==> (Opcional) mathjs para Node (solo si querés corrcoef en JS)"
# npm init -y >/dev/null 2>&1 || true
# npm install mathjs --save

echo "==> Listo. Dependencias instaladas para Problema 3."
