# Docker Repo
Builder for the repo.sgtcoder.com apt repository: Debian slim with aptly, GnuPG, curl and jq.

Runs `build_repo.sh` from the mounted `/scripts` folder, then exits. Built nightly on the server; nginx serves the published files.

- `sgtcoder/repo:latest` - linux/amd64
