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

```
sudo semodule -i selinux/openvpn_client_pod.cil /usr/share/udica/templates/base_container.cil
```

## Configurations

Put your `ovpn` file into `configs/` and rename it as `client-01.ovpn`. Then, execute the following command to allow to be mounted into container:
```
chcon -R -v -t container_file_t ./configs
```


## Running

```
sudo podman play kube pods/openvpn-client-01-pod.yaml
```


## Routing VPN access to Linux host

Verify that IP forwarding is enabled in the container:
```
sudo podman exec -it openvpn-client-01-pod-srv01 sysctl -a | grep forward
```

If not enabled, try destroy and re-create pod.

Get the OpenVPN client container IP address:
```
sudo podman container inspect openvpn-client-01-pod-srv01 | grep IPAddress
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
podman run -it --rm --pod=mypod -v ./configs/client-01.ovpn:/etc/openvpn/client/client.conf:ro --privileged --security-opt label=type:openvpn_client_pod.process extra2000/openvpn-client
```

**Note**: The `--privileged` parameter is used because rootless Podman 3.4.1 seems impossible to run with `--cap-add CAP_NET_ADMIN --cap-add CAP_NET_RAW --cap-add CAP_MKNOD`.


## Known Issues

To fix error "iptables v1.8.4 (legacy): can't initialize iptables table 'nat': Table does not exist (do you need to insmod?)", try to load `ip_tables` kernel module using the following command:
```
sudo modprobe ip_tables
```

This usually occurs on AlmaLinux 8.5.
