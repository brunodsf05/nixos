#!/usr/bin/env bash

# --- OPTIONS --- #

profiles=(
    "vm"
    "wsl"
)

rebuild_methods=(
    "boot"
    "switch"
)

# --- INITIALIZE SCRIPT --- #
set -e

LOG_FILE="$HOME/nixos-install.log"
REPO_URL="https://github.com/brunodsf05/nixos.git"
REPO_SRC="$HOME/NixOS"

exec > >(tee -a "$LOG_FILE") 2>&1

trap 'stty echo' EXIT
trap 'echo "[ERROR] Line $LINENO failed. Exit code: $?"' ERR
trap 'echo "[ERROR] Checkout $LOG_FILE"' ERR

# --- CLONE THE CONFIG IF RUNNING FROM CURL --- #
did_clone=0
if [ ! -f "$REPO_SRC/flake.nix" ] || [ ! -f "$REPO_SRC/install.sh" ]; then
    nix-shell -p git --run "git clone \"$REPO_URL\" \"$REPO_SRC\""
    did_clone=1
fi

# --- UTILITIES --- #
select_string() {
    local -a options=("$@")
    local index=0
    local key=""
    local i=0
    local tty="/dev/tty"

    stty -echo
    trap 'stty echo' RETURN

    while true; do
        for i in "${!options[@]}"; do
            if [ "$i" -eq "$index" ]; then
                printf "> \033[33m%s\033[0m\n" "${options[$i]}" > "$tty"
            else
                printf "  %s\n" "${options[$i]}" > "$tty"
            fi
        done

        IFS= read -rsn1 key < "$tty"

        if [[ "$key" == $'\x1b' ]]; then
            read -rsn2 key < "$tty"
            case "$key" in
                "[A") index=$((index - 1)) ;;  # Up
                "[B") index=$((index + 1)) ;;  # Down
            esac
        elif [[ "$key" == "" ]]; then
            break
        fi

        (( index < 0 )) && index=$(( ${#options[@]} - 1 ))
        (( index >= ${#options[@]} )) && index=0

        for ((i=0; i<${#options[@]}; i++)); do
            printf "\033[F\033[K" > "$tty"
        done
    done

    stty echo
    trap - RETURN

    printf "%s" "${options[$index]}"
}

# --- INSTALLER TUI --- #

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
printf "Dotfiles installer!"
printf "\033[90mTo cancel please use ctrl-c\033[0m\n"

if [ "$did_clone" -eq 1 ]; then
    printf "\n\033[32mDo you want to rebuild the configuration?\033[0m\n"
    rebuild_choice="$(select_string "yes" "no")"
    if [ "$rebuild_choice" = "no" ]; then
        echo
        echo "Exiting without rebuild."
        exit 0
    fi
fi

printf "\n\033[32mWhat is your system?\033[0m\n"
chosen_profile="$(select_string "${profiles[@]}")"

printf "\n\033[32mWhat rebuild method will you use?\033[0m\n"
chosen_rebuild_method="$(select_string "${rebuild_methods[@]}")"

# --- COUNTDOWN --- #
seconds=3
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

# --- INSTALLATION --- #
printf "\r\033[K\033[36mInstalling $chosen_profile!\033[0m\n\n"

sudo \
  NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" \
  nix-shell -p git --run \
  "nixos-rebuild $chosen_rebuild_method --flake \"$REPO_SRC#$chosen_profile\""

# --- POST INSTALLATION --- #

# Display success
[ "$chosen_rebuild_method" = "switch" ] && fastfetch > /dev/tty
printf "\n\033[35mSystem successfully rebuilt!\033[0m\n\n"

# Post install steps
printf "\033[90mPerform the following to complete the setup...\033[0m\n"
if [ "$chosen_rebuild_method" = "switch" ]; then
    printf "1. "
else
    printf "1. Restart your system.\n2. "
fi
printf 'Perform an "nh clean all" to gain storage!\n'

[ "$chosen_profile" = "wsl" ] && echo 'For WSL execute "wsl --shutdown"'
