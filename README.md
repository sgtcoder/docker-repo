# Docker Aptly
repo.sgtcoder.com: nginx serving the apt repository, plus an hourly aptly build (`/scripts/build_repo.sh`, mounted from the server).

- `sgtcoder/aptly:latest` - linux/amd64, Debian slim, listens on 8080
