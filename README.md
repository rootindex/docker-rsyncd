# Rsyncd, with multiple shares (volume mounts)

Pretty small alpine rsync read-only daemon container, this is not secure in any way or manner - to be used on a private networks with a [vpn server](https://hub.docker.com/search/?q=ipsec+vpn&type=image). 

This setup does not include a SSH Daemon! your princess is in [another castle](https://hub.docker.com/search/?q=rsync+ssh&type=image).

Without any arguments the daemon will mount to the /data path. To use custom volume paths use the MOUNTS environment with paths /comma,/separated.

rsyncd.conf is not meant to be persistent, just destroy and recreate when adding more volumes.

_Port 873 is exposed in the Dockerfile, not recommended to bind it on the host unless you know what you are doing._

## Example usage

```bash
# easy mode
docker run \
    --detach \
    --volume /srv/my-data-path:/data \
    coisio/rsyncd:latest

# the reason to use this one
docker run \
    --detach \
    --volume /var/archives:/backups \
    --volume /mnt/media-mount:/media \
    --env MOUNTS="/backups,/media" \
    coisio/rsyncd:latest        
```
