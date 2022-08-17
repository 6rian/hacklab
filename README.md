# hacklab

A Docker-based Kali Linux lab for pentesting, CTFs, and bug bounty hunting.

## Installation

### Prerequisites
You will need to download and install [Docker Desktop](https://docs.docker.com/get-docker/) prior to using this lab.

### Setup
*The first time setup will take around 20+ minutes to complete.*

1. Clone this repository.
2. `./bootstrap.sh` add hacklab to your SSH configuration. *(optional)*
3. `docker compose up -d` to build the image and start the container.

## Usage

### Container Orchestration
**Build and start container:**
```bash
docker compose up -d
```

**Start already built container:**
```bash
docker compose start
```

**Stop container:**
```bash
docker compose stop
```

### Connecting To The Lab

If you ran the bootstrap script during installation, simply `ssh hacklab` to connect to the lab.

If not, connect with `ssh brian@localhost -p 2222 -D 1337` where:
- `-p` is the SSH port exposed to the host.
- `-D` is the port for SOCKS proxy traffic.

### Using Burp Suite On The Host

Set the SOCKS proxy settings (`localhost:1337`) under the "User options" tab of Burp Suite to proxy traffic from the host through the lab. This requires having an active SSH connection to the lab with dynamic port forwarding enabled to work.

## Troubleshooting

### Host key verification failed.

> It is also possible that a host key has just been changed.

If you see this error after a complete rebuild (meaning the root volume was deleted and recreated), you will need to delete the lab's host key from your `~/.ssh/known_hosts` file. It will start with something like this: `[localhost]:2222 ecdsa-sha2-nistp256`.

## Future Improvements

[] Replace install of `kali-linux-headless` metapackage with handpicked tools to get build size and time down.