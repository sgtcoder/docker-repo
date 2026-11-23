FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget jq gnupg dirmngr nginx \
    && curl -fsSL https://www.aptly.info/pubkey.txt | gpg --dearmor -o /usr/share/keyrings/aptly.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/aptly.gpg] http://repo.aptly.info/ci trixie main" \
        > /etc/apt/sources.list.d/aptly.list \
    && apt-get update && apt-get install -y --no-install-recommends aptly \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 repo && useradd -u 1000 -g 1000 -d /home/www-data -M -s /bin/bash repo
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV HOME=/home/www-data
USER repo
EXPOSE 8080
HEALTHCHECK --start-period=30s --interval=30s --timeout=30s --retries=5 CMD curl --fail http://127.0.0.1:8080 || exit 1
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
