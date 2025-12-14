sign() {
  if [ -z "$1" ]; then
    echo -e "\033[1;33mUsage:\033[0m sign <file_name>"
    return 1
  fi
  
  # Check if file is text
  if file -b --mime-type "$1" | grep -q '^text/'; then
    gpg --armor --clearsign "$1"
  else
    gpg --armor --detach-sign "$1"
  fi
}

verify() {
  if [ -z "$1" ]; then
    echo -e "\033[1;33mUsage:\033[0m verify <file_name>"
    return 1
  fi
  gpg --verify "$1"
}

encrypt() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "\033[1;33mUsage:\033[0m encrypt <recipient> <file_name> [--anonymous] [--binary]"
    echo -e "  \033[1;36m--anonymous:\033[0m Encrypt without signing"
    echo -e "  \033[1;36m--binary:\033[0m Output binary format (no ASCII armor). Using ASCII armor increases file size by ~33%."
    return 1
  fi
  
  local armor="--armor"
  local sign="--sign"
  
  # Check for flags
  for arg in "$@"; do
    if [ "$arg" = "--anonymous" ]; then
      sign=""
    elif [ "$arg" = "--binary" ]; then
      armor=""
    fi
  done
  
  gpg $armor $sign --encrypt --recipient "$1" "$2"
}

decrypt() {
  if [ -z "$1" ]; then
    echo -e "\033[1;33mUsage:\033[0m decrypt <file_name>"
    return 1
  fi
  local output_file="${1%.asc}"
  output_file="${output_file%.gpg}"
  gpg --decrypt --output "$output_file" "$1"
}