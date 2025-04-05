#!/bin/bash
programName=$1
programName=${programName:?'program name is missing. Usage ./BashScriptGenerator myNewProgram.sh'}

if [[ "$programName" != *.sh ]]; then
  echo "Error: '$programName' must have a .sh extension."
  exit 1
fi

echo '#!/bin/bash' > "$programName"
chmod +x "$programName"
