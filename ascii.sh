ascii_art='
____   ____                          
\   \ /   /____   ____  __ __  ______
 \   Y   // __ \ /    \|  |  \/  ___/
  \     /\  ___/|   |  \  |  /\___ \ 
   \___/  \___  >___|  /____//____  >
              \/     \/           \/
-
'

# Define the color gradient (shades of yellow, orange and red)
colors=(
  '\033[0;38;5;187m' # Light Yellow
  '\033[0;38;5;220m' # Mustard
  '\033[0;38;5;214m' # Pastel Orange
  '\033[0;38;5;208m' # Royal Orange
  '\033[0;38;5;166m' # Smashed Pumpkin
  '\033[0;38;5;160m' # Ferrari Red
  '\033[0;38;5;15m'  # White
)

# Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Print each line with the corresponding color
for i in "${!lines[@]}"; do
  color_index=$((i % ${#colors[@]}))
  echo -e "${colors[color_index]}${lines[i]}"
done

