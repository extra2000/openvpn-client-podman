# Changelog

### [2.0.1](https://github.com/extra2000/openvpn-client-podman/compare/v2.0.0...v2.0.1) (2022-04-04)


### Documentations

* **README:** add instructions to load `ip_tables` at boot ([ad21ec8](https://github.com/extra2000/openvpn-client-podman/commit/ad21ec88e05457b30d12e1dd321ed0706154f16d))
* **README:** improve static IP with auto-start at boot ([715128f](https://github.com/extra2000/openvpn-client-podman/commit/715128fb60d03f6534054d393640c0a97732c3f0))

## [2.0.0](https://github.com/extra2000/openvpn-client-podman/compare/v1.0.3...v2.0.0) (2022-03-10)


### ⚠ BREAKING CHANGES

* Project structure, SELinux Policy name, Pod name, and config name has changed

### Code Refactoring

* reorganize SELinux Policy and Pod into example ([3afbe4d](https://github.com/extra2000/openvpn-client-podman/commit/3afbe4d93faf227ee3a1c6ba8ab08196da483933))


### Documentations

* **README:** add instructions for static IPv4 ([be6442a](https://github.com/extra2000/openvpn-client-podman/commit/be6442a5aeeb16d93da27f1413b4c965f28a8b1d))
* **README:** update config and pod names ([b7176a2](https://github.com/extra2000/openvpn-client-podman/commit/b7176a2a01c47ead31933f1251943d342a6fcd39))
* **README:** update configs instruction ([8779708](https://github.com/extra2000/openvpn-client-podman/commit/87797083ee86438ff0acb4c3f716fdf84da10a3f))
* **README:** update running instructions ([fa7a2ef](https://github.com/extra2000/openvpn-client-podman/commit/fa7a2ef2d0ae42292d2e16cd49aa9dda91de725a))
* **README:** update SELinux instructions ([92b33b8](https://github.com/extra2000/openvpn-client-podman/commit/92b33b832231b44c4994684c466341742c59e2cd))

### [1.0.3](https://github.com/extra2000/openvpn-client-podman/compare/v1.0.2...v1.0.3) (2021-11-21)


### Fixes

* **selinux:** remove `user_home_t` ([173730a](https://github.com/extra2000/openvpn-client-podman/commit/173730a72eef9985636bbbe06eb6e60ffa73fdfb))


### Documentations

* **README:** add instructions to label `./configs/` directory ([dd712ce](https://github.com/extra2000/openvpn-client-podman/commit/dd712ce3e3ed5a459f168444b48720e420121b66))

### [1.0.2](https://github.com/extra2000/openvpn-client-podman/compare/v1.0.1...v1.0.2) (2021-11-18)


### Documentations

* **README:** add Section "Known Issues" ([3ab0a86](https://github.com/extra2000/openvpn-client-podman/commit/3ab0a86c2b0c46f7eb25acb99098cfeb6ac27278))

### [1.0.1](https://github.com/extra2000/openvpn-client-podman/compare/v1.0.0...v1.0.1) (2021-11-17)


### Documentations

* **README:** add instructions to provide VPN access to a pod ([c3c402c](https://github.com/extra2000/openvpn-client-podman/commit/c3c402c93f08504bbde17be63dc2363f4a4f5887))


### Fixes

* **selinux:** allow tun tap for rootless container ([cc309ad](https://github.com/extra2000/openvpn-client-podman/commit/cc309ad709de86e6c41213c12ed10a080753b63e))

## 1.0.0 (2021-10-31)


### Features

* initial commit ([ee20259](https://github.com/extra2000/openvpn-client-podman/commit/ee20259eef1b697251e652bb583ee3a745a18494))


### Documentations

* **README:** update `README.md` ([efb51f7](https://github.com/extra2000/openvpn-client-podman/commit/efb51f758178df549a73427309aca11e548acca2))


### Continuous Integrations

* add AppVeyor with `semantic-release` ([b4face5](https://github.com/extra2000/openvpn-client-podman/commit/b4face5c5d051e0216a4113329cb7000690bb58f))
