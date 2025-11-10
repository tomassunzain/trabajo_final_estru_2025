#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
echo "==> Ejecutando Problema 3 en todos los lenguajes"

# Python (usar venv para numpy)
echo "---- Python (NumPy) -----------------------------"
. .venv-p3/bin/activate
python3 Problema3_Python.py
deactivate

# R
echo "---- R -----------------------------------------"
Rscript Problema3_R.r

# Ruby
echo "---- Ruby --------------------------------------"
ruby Problema3_Ruby.rb

# C# (dotnet project temporal)
echo "---- C# (.NET) ---------------------------------"
WORKDIR=".build/cs/p3"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
dotnet new console -n p3 -o "$WORKDIR" --framework net8.0 >/dev/null
cp "$ROOT/Problema3_CSharp.cs" "$WORKDIR/Program.cs"
dotnet run --project "$WORKDIR"

# JavaScript (Node) — versión manual (mathjs opcional)
echo "---- Node.js -----------------------------------"
node Problema3_JavaScript.js

echo "==> OK. Fin de run.sh para Problema 3."
#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
echo "==> Ejecutando Problema 3 en todos los lenguajes"

# Python (usar venv para numpy)
echo "---- Python (NumPy) -----------------------------"
. .venv-p3/bin/activate
python3 Problema3_Python.py
deactivate

# R
echo "---- R -----------------------------------------"
Rscript Problema3_R.r

# Ruby
echo "---- Ruby --------------------------------------"
ruby Problema3_Ruby.rb

# C# (dotnet project temporal)
echo "---- C# (.NET) ---------------------------------"
WORKDIR=".build/cs/p3"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
dotnet new console -n p3 -o "$WORKDIR" --framework net8.0 >/dev/null
cp "$ROOT/Problema3_CSharp.cs" "$WORKDIR/Program.cs"
dotnet run --project "$WORKDIR"

# JavaScript (Node) — versión manual (mathjs opcional)
echo "---- Node.js -----------------------------------"
node Problema3_JavaScript.js

echo "==> OK. Fin de run.sh para Problema 3."
