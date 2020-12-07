# direnv

**direnv** is an extension for your shell. It augments existing shells with a new feature that can load and unload environment variables depending on the current directory.

## Installation on Ubuntu
1. Install from 
```
sudo apt add direnv
```
2. Add to ~/.bashrc (at the end of file)
```
...
eval "$(direnv hook bash)"
```

## Usage
1. Add .evnrc file in target directory
```
#> echo VAR=value > .envrc
```
2. Allow direnv
```
#> direnv allow .
```
3. Check status
```
#> derenv status
direnv exec path /usr/bin/direnv
DIRENV_CONFIG /home/vegorov/.config/direnv
DIRENV_BASH /bin/bash
Loaded RC path /mnt/c/Projects/autoqa/reporting/utils/.envrc
Loaded watch: ".envrc" - 2020-12-07T17:04:35+03:00
Loaded watch: "../../../../../../home/vegorov/.config/direnv/allow/900c824785fbdf9679327b7aefd2bb580eeb2a4b5ba27ceca9f059d1c83ebfc4" - 2020-12-07T17:28:10+03:00
Loaded RC allowed false
Loaded RC allowPath
Found RC path /mnt/c/Projects/autoqa/reporting/utils/.envrc
Found watch: ".envrc" - 2020-12-07T17:04:35+03:00
Found watch: "../../../../../../home/vegorov/.config/direnv/allow/900c824785fbdf9679327b7aefd2bb580eeb2a4b5ba27ceca9f059d1c83ebfc4" - 2020-12-07T17:28:10+03:00
Found RC allowed true
Found RC allowPath /home/vegorov/.config/direnv/allow/900c824785fbdf9679327b7aefd2bb580eeb2a4b5ba27ceca9f059d1c83ebfc4

## URLs
https://direnv.net