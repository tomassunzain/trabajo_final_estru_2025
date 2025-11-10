#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
echo "==> Ejecutando Problema 2 en todos los lenguajes"

# Python
echo "---- Python ------------------------------------"
python3 Problema2_Python.py

# R
echo "---- R -----------------------------------------"
Rscript Problema2_R.r

# Ruby
echo "---- Ruby --------------------------------------"
ruby Problema2_Ruby.rb

# C# (dotnet project temporal)
echo "---- C# (.NET) ---------------------------------"
WORKDIR=".build/cs/p2"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
dotnet new console -n p2 -o "$WORKDIR" --framework net8.0 >/dev/null
cp "$ROOT/Problema2_CSharp.cs" "$WORKDIR/Program.cs"
dotnet run --project "$WORKDIR"

# JavaScript (Node)
echo "---- Node.js -----------------------------------"
node Problema2_JavaScript.js

echo "==> OK. Fin de run.sh para Problema 2."
