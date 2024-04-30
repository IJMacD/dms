FROM ubuntu
COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin
COPY dms.sh /
ENTRYPOINT [ "/dms.sh" ]