FROM eclipse-mosquitto
RUN mkdir -p /scripts
COPY forward.sh /scripts
COPY docker-entrypoint.sh .
RUN chmod +x /scripts/forward.sh
RUN chmod +x /docker-entrypoint.sh
