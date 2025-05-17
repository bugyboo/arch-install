# Docker setup

- yay -S docker docker-compose docker-buildx

- Create a file in /etc/docker/daemon.json

```
    {
        "data-root": "/home/user/docker"
    }
```

- Enable and start docker.service

- Add user to docker group, usermod -aG xxx docker

- logout and login again.
