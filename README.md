## GPU docker

follow the instruction [here](https://github.com/nvidia/nvidia-container-runtime#daemon-configuration-file) to change default docker run-time to nvidia-docker

```shell
export UID=$(id -u $USER)
export GID=$(id -g $USER)
# or you can write this into .env
docker-compose up -d
ssh zbc@localhost -p 8222 # passwd: zbc
```

### TODO:

- [ ] jupyter passwd
- [ ] frpc setup
