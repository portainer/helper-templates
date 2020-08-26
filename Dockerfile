FROM scratch

WORKDIR /app

COPY bin /app

ENTRYPOINT ["/app/helper-templates"]