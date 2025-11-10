#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
echo "==> Ejecutando Problema 1 en todos los lenguajes"

# Python
echo "---- Python ------------------------------------"
python3 Problema1_Python.py

# R
echo "---- R -----------------------------------------"
Rscript Problema1_R.r

# Ruby
echo "---- Ruby --------------------------------------"
ruby Problema1_Ruby.rb

# C# (dotnet project temporal)
echo "---- C# (.NET) ---------------------------------"
WORKDIR=".build/cs/p1"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
dotnet new console -n p1 -o "$WORKDIR" --framework net8.0 >/dev/null
# Reemplazar Program.cs con tu archivo
cp "$ROOT/Problema1_CSharp.cs" "$WORKDIR/Program.cs"
dotnet run --project "$WORKDIR"

# JavaScript (Node)
echo "---- Node.js -----------------------------------"
node Problema1_JavaScript.js

echo "==> OK. Fin de run.sh para Problema 1."
