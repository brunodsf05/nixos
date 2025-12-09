#!/usr/bin/env bash

# Profile selector
profiles=("wsl")
index=0

stty -echo

while true; do
    printf "\033c"
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
            "[A") ((index--)) ;;   # Up
            "[B") ((index++)) ;;   # Down
        esac
    elif [[ "$key" == "" ]]; then
        break
    fi

    (( index < 0 )) && index=$(( ${#profiles[@]} - 1 ))
    (( index >= ${#profiles[@]} )) && index=0
done

stty echo

chosen="${profiles[$index]}"

# Countdown before installing
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

sudo NIX_CONFIG="experimental-features = nix-command flakes" \
    nixos-rebuild switch --flake ".#$chosen"

# Postinstall
echo
echo "Welcome!"
echo
fastfetch
echo
echo 'It is recommended to run restart your system and perform an "nh os clean"'
echo 'For wsl execute "wsl --shutdown"'
