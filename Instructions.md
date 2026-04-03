# Uninstall ohmyzsh
sh ~/.oh-my-zsh/tools/uninstall.sh

# Delete the Oh My Zsh folder
rm -rf ~/.oh-my-zsh

# Set the shell to zsh (if needed)
chsh -s /usr/bin/zsh

# Install starship
sudo apt install starship


# Create a new .zshrc
nano ~/.zshrc

# Paste the following into ~/.zshrc
alias temp="echo $((`cat /sys/class/thermal/thermal_zone0/temp|cut -c1-2`)).$((`cat /sys/class/thermal/thermal_zone0/temp|cut -c3-5`))"
alias bat="batcat"
fastfetch
eval "$(starship init zsh)"

# Make sure starship is added to the end of ~/.zshrc:
eval "$(starship init zsh)"

# Create starship.toml at .config/starship.toml and paste the following customization

format = "$all$custom$line_break$character"

[localip]
ssh_only = false
format = '@[$localipv4](bold red) '
disabled = false

[directory]
truncation_length = 8
truncation_symbol = '…/'

[memory_usage]
disabled = false
threshold = -1
symbol = ' '
style = 'bold dimmed green'

[git_status]
conflicted = '🏳'
ahead = '🏎💨'
behind = '😰'
diverged = '😵'
up_to_date = '✓'
untracked = '🤷'
stashed = '📦'
modified = '📝'
staged = '[++\($count\)](green)'
renamed = '👅'
deleted = '🗑'

[custom.uptime]
command = "uptime -p | sed 's/up //' | sed 's/ days\\?,/d/' | sed 's/ hours\\?,/h/' | sed 's/ minutes\\?/m/'"
when = true
symbol = "up "
style = "bold yellow"
format = "[$symbol$output]($style) "

[custom.temp]
command = "vcgencmd measure_temp | sed \"s/temp=//;s/'C//\""
when = "command -v vcgencmd > /dev/null 2>&1"
symbol = "T:"
style = "bold red"
format = "[$symbol${output}°C]($style) "

# RISC-V 64 / generic Linux (reads temperature from sysfs, auto-hides on Raspberry Pi)
# Check available zones first: for z in /sys/class/thermal/thermal_zone*/temp; do echo "$z: $(cat $z)"; done
[custom.temp_riscv]
command = "awk '{printf \"%.0f\", $1/1000}' /sys/class/thermal/thermal_zone0/temp"
when = "test -f /sys/class/thermal/thermal_zone0/temp && ! command -v vcgencmd > /dev/null 2>&1"
symbol = "T:"
style = "bold red"
format = "[$symbol${output}°C]($style) "



