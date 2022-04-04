# openvpn-client-podman

| License | Versioning | Build |
| ------- | ---------- | ----- |
| [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) | [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) | [![Build status](https://ci.appveyor.com/api/projects/status/86kv2703xl8t49qa?svg=true)](https://ci.appveyor.com/project/nikAizuddin/openvpn-client-podman) |

OpenVPN client deployment using Podman.


## Building image

```
sudo podman build -t extra2000/openvpn-client .
```


## Load SELinux policy

Create SELinux Policy:
```
cp -v selinux/openvpn_client_podman.cil{.example,}
```

Load the SELinux Policy:
```
sudo semodule -i selinux/openvpn_client_podman.cil /usr/share/udica/templates/base_container.cil
```


## Configurations

Put your `ovpn` file into `configs/` and rename it as `client.ovpn`. Then, execute the following command to allow to be mounted into container:
```
chcon -R -v -t container_file_t ./configs
```

Create pod file:
```
cp -v openvpn-client-pod.yaml{.example,}
```


## Running

Execute the following command to spawn a pod:
```
sudo podman play kube openvpn-client-pod.yaml
```


## Running with Static IPv4

Create a pod with static IPv4 address:
```
sudo podman pod create --ip 10.88.1.2 --name openvpn-client-pod
```

Spawn an OpenVPN container into the pod:
```
sudo podman run -it -d --pod openvpn-client-pod --restart unless-stopped --sysctl net.ipv4.ip_forward=1 -v ./configs/client.ovpn:/etc/openvpn/client/client.conf:ro --cap-add CAP_NET_ADMIN --cap-add CAP_NET_RAW --cap-add CAP_MKNOD --security-opt label=type:openvpn_client_podman.process --name openvpn-client-pod-srv01 extra2000/openvpn-client
```

Generate OpenVPN container systemd script to auto-start at boot:
```
cd /etc/systemd/system
sudo podman generate systemd --files --name openvpn-client-pod-srv01
```

Create `/etc/systemd/system/openvpn-ip-route.service` to auto add IP route at boot (NOTE: Change `192.168.123.0/24` to your IP range that you want to access):
```
[Unit]
Description=Add IP route for host connection through OpenVPN Client Podman
After=container-openvpn-client-pod-srv01.service

[Service]
ExecStartPre=/bin/sleep 10
ExecStart=/usr/sbin/ip route add 192.168.123.0/24 via 10.88.1.2 dev cni-podman0
Type=oneshot

[Install]
WantedBy=multi-user.target
```

Apply changes:
```
sudo systemctl daemon-reload
sudo systemctl enable container-openvpn-client-pod-srv01.service openvpn-ip-route.service
```


## Routing VPN access to Linux host

Verify that IP forwarding is enabled in the container:
```
sudo podman exec -it openvpn-client-pod-srv01 sysctl -a | grep forward
```

If not enabled, try destroy and re-create pod.

Get the OpenVPN client container IP address:
```
sudo podman container inspect openvpn-client-pod-srv01 | grep IPAddress
```

Assuming the IP address of the container is `10.88.0.2`, execute the following command on host:
```
sudo ip route add 192.168.123.0/24 via 10.88.0.2
```


## Routing VPN access to Windows host (WSL2)

Find out WSL2 IP address:
```
wsl hostname -I
```

Assuming the WSL2 IP address is `172.28.96.149`, execute the following powershell command as `Administrator`:
```
route add 192.168.123.0 mask 255.255.255.0 172.24.63.186
```


## Using Rootless Podman `run` to provide VPN access to existing Podman pod

To provide VPN access to existing pod (assuming the pod name is `mypod`), execute the following command:
```
podman run -it --rm --pod=mypod -v ./configs/client.ovpn:/etc/openvpn/client/client.conf:ro --privileged --security-opt label=type:openvpn_client_podman.process extra2000/openvpn-client
```

**Note**: The `--privileged` parameter is used because rootless Podman 3.4.1 seems impossible to run with `--cap-add CAP_NET_ADMIN --cap-add CAP_NET_RAW --cap-add CAP_MKNOD`.


## Known Issues

To fix error "iptables v1.8.4 (legacy): can't initialize iptables table 'nat': Table does not exist (do you need to insmod?)", try to load `ip_tables` kernel module using the following command:
```
sudo modprobe ip_tables
```

Then, create `/etc/modules-load.d/ip_tables.conf` file with the following content:
```
ip_tables
```

This usually occurs on AlmaLinux 8.5.
