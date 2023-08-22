cat start-docker.sh | grep name | cut -d= -f2 | sed 's/\\//g' | xargs docker stop 2>/dev/null
cat start-docker.sh | grep name | cut -d= -f2 | sed 's/\\//g' | xargs docker rm 2>/dev/null
