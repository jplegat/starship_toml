#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# When run with sudo, $HOME becomes /root. Resolve the real user's home.
if [ -n "$SUDO_USER" ]; then
  REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
  REAL_HOME="$HOME"
fi

echo "==> Uninstalling Oh My Zsh (if present)..."
if [ -f "$REAL_HOME/.oh-my-zsh/tools/uninstall.sh" ]; then
  sh "$REAL_HOME/.oh-my-zsh/tools/uninstall.sh"
fi
rm -rf "$REAL_HOME/.oh-my-zsh"

echo "==> Setting default shell to zsh..."
chsh -s /usr/bin/zsh

echo "==> Installing starship..."
apt install -y starship

echo "==> Backing up existing .zshrc (if any)..."
[ -f "$REAL_HOME/.zshrc" ] && cp "$REAL_HOME/.zshrc" "$REAL_HOME/.zshrc.bak" && echo "    Saved to ~/.zshrc.bak"

echo "==> Writing new .zshrc..."
cat > "$REAL_HOME/.zshrc" << 'EOF'
alias temp="echo $((`cat /sys/class/thermal/thermal_zone0/temp|cut -c1-2`)).$((`cat /sys/class/thermal/thermal_zone0/temp|cut -c3-5`))"
alias bat="batcat"
fastfetch
eval "$(starship init zsh)"
EOF

echo "==> Installing starship.toml..."
mkdir -p "$REAL_HOME/.config"
cp "$SCRIPT_DIR/starship.toml" "$REAL_HOME/.config/starship.toml"

echo ""
echo "Done! Run 'exec zsh' or open a new terminal to start using starship."
