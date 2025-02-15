# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Remove image by tag
# Usage: drmit 'part_of_image_name1\|image_name2'
# Not for use with numbers that could exist as IDs 
drit() { docker images --format '{{.ID}} {{.Tag}}' | grep $1 | awk '{print $1;}' | xargs -n1 -P4 -r docker rmi; }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# Show with special format
alias dformat="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}'"

# Get containers by exact image/parent-image name
dpsi() { docker ps --filter "ancestor=$1"; }

# Get containers even exited by exact image/parent-image name
dpsai() { docker ps -a --filter "ancestor=$1"; }
