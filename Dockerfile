FROM docker.io/library/ubuntu:20.04

RUN apt update && apt install -y openvpn iputils-ping iptables dos2unix

COPY entrypoint.sh /bin/entrypoint.sh
RUN dos2unix /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/usr/sbin/openvpn", "--config", "/etc/openvpn/client/client.conf"]
