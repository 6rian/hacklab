# hacklab

A Docker-based Kali Linux lab for pentesting, CTFs, and bug bounty hunting.

## Installation

### Prerequisites
You will need to download and install [Docker Desktop](https://docs.docker.com/get-docker/) prior to using this lab.

### Setup
*The first time setup will take around 20+ minutes to complete.*

1. Clone this repository.
2. `./install.sh`
3. `ssh hacklab` *See the `Dockerfile` for the default root password.*
4. Change root's password: `passwd`.

## Usage

### Container Orchestration

**Build and start container:**
```bash
docker compose up -d
```

**Start already built container:**
```bash
docker compose start hacklab
```

**Stop container:**
```bash
docker compose stop hacklab
```

**Destroy container:**
```bash
docker compose down
```

### Connecting To The Lab

```bash
ssh hacklab
```

### Using Burp Suite On The Host

Set the SOCKS proxy settings (`localhost:1337`) under the "User options" tab of Burp Suite to proxy traffic from the host through the lab. This requires having an active SSH connection to the lab with dynamic port forwarding enabled to work.

## Troubleshooting

### Host key verification failed.

> It is also possible that a host key has just been changed.

If you see this error after a complete rebuild (meaning the root volume was deleted and recreated), you will need to delete the lab's host key from your `~/.ssh/known_hosts` file. It will start with something like this: `[localhost]:2222 ecdsa-sha2-nistp256`.

## Future Improvements

[] Replace install of `kali-linux-headless` metapackage with handpicked tools to get build size and time down.

[] Incorporate dotfiles.