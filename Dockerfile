FROM debian:trixie-slim

# Tools for build_repo.sh, which is mounted at /scripts (deploy_scripts keeps it current).
# aptly from aptly's own repo, the same build the old sgtcoder/apache container ran.
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget jq gnupg dirmngr \
    && curl -fsSL https://www.aptly.info/pubkey.txt | gpg --dearmor -o /usr/share/keyrings/aptly.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/aptly.gpg] http://repo.aptly.info/ci trixie main" \
        > /etc/apt/sources.list.d/aptly.list \
    && apt-get update && apt-get install -y --no-install-recommends aptly \
    && rm -rf /var/lib/apt/lists/*

# UID 1000 owns the repo data on docker1; its home holds the GPG keyring and .aptly.conf.
RUN groupadd -g 1000 repo && useradd -u 1000 -g 1000 -d /home/www-data -M -s /bin/bash repo
ENV HOME=/home/www-data
USER repo
CMD ["/scripts/build_repo.sh"]
