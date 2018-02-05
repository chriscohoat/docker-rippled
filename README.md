# Ripple - Docker

This repo serves as a way to run the altnet from source.

1) Build this image:

```
docker build -t chriscohoat/rippled .
```

2) Run this image:

```
docker run -it --rm \
    --name ripple-node \
    -p 51235:51235 \
    -p 5006:5006 \
    -p 127.0.0.1:5005:5005 \
    chriscohoat/rippled
```

The database resides at `/var/lib/rippled/db/rocksdb` ... if you want to persist it after you stop the container:

```
docker run -it --rm \
    --name ripple-node \
    -v /home/chris/workspaces/chriscohoat/docker-rippled/data:/var/lib/rippled/db/ \
    -p 51235:51235 \
    -p 5006:5006 \
    -p 127.0.0.1:5005:5005 \
    chriscohoat/rippled
```

3) To confirm that everything is working:

```
curl -d '{ "method": "server_info", "params": [] }' 127.0.0.1:5005
```