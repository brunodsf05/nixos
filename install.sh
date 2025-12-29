#!/usr/bin/env bash

# --- INITIALIZE SCRIPT --- #
set -e

LOG_FILE="$HOME/nixos-install.log"
REPO_URL="https://github.com/brunodsf05/nixos.git"
REPO_SRC="$HOME/nixos"

exec > >(tee -a "$LOG_FILE") 2>&1

trap 'stty echo' EXIT
trap 'echo "[ERROR] Line $LINENO failed. Exit code: $?"' ERR
trap 'echo "[ERROR] Checkout $LOG_FILE"' ERR

# --- CLONE THE CONFIG IF RUNNING FROM CURL --- # 
if [ ! -f "$REPO_SRC/flake.nix" ] || [ ! -f "$REPO_SRC/install.sh" ]; then
    nix-shell -p git --run "git clone \"$REPO_URL\" \"$REPO_SRC\""
fi

# --- PROFILE SELECTOR --- #
index=0
profiles=(
    "vm"
    "wsl"
)

stty -echo

while true; do
    clear
    cat <<EOF
          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖
          ▜███▙       ▜███▙  ▟███▛
           ▜███▙       ▜███▙▟███▛
            ▜███▙       ▜██████▛
     ▟█████████████████▙ ▜████▛     ▟▙
    ▟███████████████████▙ ▜███▙    ▟██▙
           ▄▄▄▄▖           ▜███▙  ▟███▛
          ▟███▛             ▜██▛ ▟███▛
         ▟███▛               ▜▛ ▟███▛
▟███████████▛                  ▟██████████▙
▜██████████▛                  ▟███████████▛
      ▟███▛ ▟▙               ▟███▛
     ▟███▛ ▟██▙             ▟███▛
    ▟███▛  ▜███▙           ▝▀▀▀▀
    ▜██▛    ▜███▙ ▜██████████████████▛
     ▜▛     ▟████▙ ▜████████████████▛
           ▟██████▙       ▜███▙
          ▟███▛▜███▙       ▜███▙
         ▟███▛  ▜███▙       ▜███▙
         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘
EOF
    echo "Dotfiles installer!"
    echo
    printf "\033[32mPlease select your profile:\033[0m"
    echo

    for i in "${!profiles[@]}"; do
        if [ "$i" -eq "$index" ]; then
            printf "> \033[33m%s\033[0m\n" "${profiles[$i]}"
        else
            printf "  %s\n" "${profiles[$i]}"
        fi
    done

    echo
    printf "\033[90mTo cancel please use ctrl-c\033[0m\n"

    IFS= read -rsn1 key

    if [[ "$key" == $'\x1b' ]]; then
        read -rsn2 key
        case "$key" in
            "[A") index=$((index - 1)) ;;  # Up
            "[B") index=$((index + 1)) ;;  # Down
        esac
    elif [[ "$key" == "" ]]; then
        break
    fi

    (( index < 0 )) && index=$(( ${#profiles[@]} - 1 ))
    (( index >= ${#profiles[@]} )) && index=0
done

stty echo

chosen="${profiles[$index]}"

# --- PROFILE SELECTOR --- #
seconds=5
echo
for ((n=seconds; n>=1; n--)); do
  printf "\r\033[K\033[31m"
  printf "Installing in $n"
  for _ in 1 2 3; do
    printf "."
    sleep 0.25
  done
  printf "\033[0m"
done

# Install
printf "\r\033[K\033[36mInstalling $chosen!\033[0m\n"
echo

sudo \
  NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" \
  nix-shell -p git --run \
  "nixos-rebuild switch --flake \"$REPO_SRC#$chosen\""

# --- POST INSTALLATION --- #
echo
echo "Welcome!"
echo
fastfetch
echo
echo 'It is recommended to run restart your system and perform an "nh clean all"'
[ "$chosen" = "wsl" ] && echo 'For WSL execute "wsl --shutdown"'
