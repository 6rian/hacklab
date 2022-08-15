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


## Troubleshooting

### Host key verification failed.

> It is also possible that a host key has just been changed.

If you see this error after a complete rebuild (meaning the root volume was deleted and recreated), you will need to delete the lab's host key from your `~/.ssh/known_hosts` file. It will start with something like this: `[localhost]:2222 ecdsa-sha2-nistp256`.

## Future Improvements

[] Replace install of `kali-linux-headless` metapackage with handpicked tools to get build size and time down.