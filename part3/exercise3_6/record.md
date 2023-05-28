# Container Optimization Exercise
What to do:
1. Optimize container build by using multistage build (aka. builder pattern)
2. Compare image size before & after optimization

## Objective
The objective of this exercise is to optimize the container build by using multistage build (aka. builder pattern) and compare image size before and after optimization.

## After optimization
Was able to reduce image size of `devopsdocker/back:latest` from over 400MB to just ~26MB
`devopsdocker/front:latest` from +400MB to just ~42MB

```
michaelng@mich-sci exercise3_6 % docker images     
REPOSITORY                                                  TAG           IMAGE ID       CREATED          SIZE
devopsdocker/front                                          latest        ff18f62c8740   10 minutes ago   42.6MB
devopsdocker/back                                           latest        f75f6f8dcff5   36 minutes ago   25.9MB
```

### img his, example-backend
```
michaelng@mich-sci exercise3_6 % docker image history devopsdocker/back
IMAGE          CREATED              CREATED BY                                      SIZE      COMMENT
f75f6f8dcff5   About a minute ago   CMD ["./server"]                                0B        buildkit.dockerfile.v0
<missing>      About a minute ago   USER appuser                                    0B        buildkit.dockerfile.v0
<missing>      About a minute ago   RUN /bin/sh -c adduser -D appuser # buildkit    4.68kB    buildkit.dockerfile.v0
<missing>      About a minute ago   COPY /server . # buildkit                       18.6MB    buildkit.dockerfile.v0
<missing>      3 minutes ago        WORKDIR /usr/src/app                            0B        buildkit.dockerfile.v0
<missing>      2 weeks ago          /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B        
<missing>      2 weeks ago          /bin/sh -c #(nop) ADD file:7625ddfd589fb824e…   7.33MB 
```

### img his, example-frontend

```
michaelng@mich-sci exercise3_6 % docker image history devopsdocker/front  
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
ff18f62c8740   13 minutes ago   COPY /usr/src/app/build /usr/share/nginx/htm…   1.19MB    buildkit.dockerfile.v0
<missing>      3 days ago       /bin/sh -c set -x     && apkArch="$(cat /etc…   29.6MB    
<missing>      3 days ago       /bin/sh -c #(nop)  ENV NJS_VERSION=0.7.12       0B        
<missing>      3 days ago       /bin/sh -c #(nop)  CMD ["nginx" "-g" "daemon…   0B        
<missing>      3 days ago       /bin/sh -c #(nop)  STOPSIGNAL SIGQUIT           0B        
<missing>      3 days ago       /bin/sh -c #(nop)  EXPOSE 80                    0B        
<missing>      3 days ago       /bin/sh -c #(nop)  ENTRYPOINT ["/docker-entr…   0B        
<missing>      3 days ago       /bin/sh -c #(nop) COPY file:e57eef017a414ca7…   4.62kB    
<missing>      3 days ago       /bin/sh -c #(nop) COPY file:36429cfeeb299f99…   3.01kB    
<missing>      3 days ago       /bin/sh -c #(nop) COPY file:5c18272734349488…   2.12kB    
<missing>      3 days ago       /bin/sh -c #(nop) COPY file:7b307b62e82255f0…   1.62kB    
<missing>      3 days ago       /bin/sh -c set -x     && addgroup -g 101 -S …   4.75MB    
<missing>      3 days ago       /bin/sh -c #(nop)  ENV PKG_RELEASE=1            0B        
<missing>      3 days ago       /bin/sh -c #(nop)  ENV NGINX_VERSION=1.25.0     0B        
<missing>      8 weeks ago      /bin/sh -c #(nop)  LABEL maintainer=NGINX Do…   0B        
<missing>      8 weeks ago      /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B        
<missing>      8 weeks ago      /bin/sh -c #(nop) ADD file:9a4f77dfaba7fd2aa…   7.05MB 
```


## Before optimization
```
michaelng@mich-sci devOpsDocker % docker images
REPOSITORY                                                  TAG           IMAGE ID       CREATED        SIZE
devopsdocker/back                                           latest        2071338eb73f   22 hours ago   487MB
devopsdocker/front                                          latest        8c3a86afc1a6   22 hours ago   468MB
```

### img his, example-backend
```michaelng@mich-sci devOpsDocker % docker image history devopsdocker/back
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
2071338eb73f   22 hours ago   CMD ["./server"]                                0B        buildkit.dockerfile.v0
<missing>      22 hours ago   USER appuser                                    0B        buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c go build # buildkit              233MB     buildkit.dockerfile.v0
<missing>      22 hours ago   ENV REQUEST_ORIGIN=http://localhost:4000        0B        buildkit.dockerfile.v0
<missing>      22 hours ago   COPY ./example-backend . # buildkit             36.1kB    buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c adduser -D appuser # buildkit    4.68kB    buildkit.dockerfile.v0
<missing>      12 days ago    WORKDIR /usr/src/app                            0B        buildkit.dockerfile.v0
<missing>      2 weeks ago    /bin/sh -c #(nop) WORKDIR /go                   0B
<missing>      2 weeks ago    /bin/sh -c mkdir -p "$GOPATH/src" "$GOPATH/b…   0B
<missing>      2 weeks ago    /bin/sh -c #(nop)  ENV PATH=/go/bin:/usr/loc…   0B
<missing>      2 weeks ago    /bin/sh -c #(nop)  ENV GOPATH=/go               0B
<missing>      2 weeks ago    /bin/sh -c set -eux;  apk add --no-cache --v…   247MB
<missing>      2 weeks ago    /bin/sh -c #(nop)  ENV GOLANG_VERSION=1.20.4    0B
<missing>      2 weeks ago    /bin/sh -c #(nop)  ENV PATH=/usr/local/go/bi…   0B
<missing>      2 weeks ago    /bin/sh -c apk add --no-cache ca-certificates   516kB
<missing>      2 weeks ago    /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>      2 weeks ago    /bin/sh -c #(nop) ADD file:7625ddfd589fb824e…   7.33MB
```

### image history, example-frontend
```
michaelng@mich-sci devOpsDocker % docker image history devopsdocker/front
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
8c3a86afc1a6   22 hours ago   CMD ["serve" "-sl" "4000" "build"]              0B        buildkit.dockerfile.v0
<missing>      22 hours ago   USER appuser                                    0B        buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c npm run build # buildkit         8.68MB    buildkit.dockerfile.v0
<missing>      22 hours ago   ENV REACT_APP_BACKEND_URL=http://localhost:8…   0B        buildkit.dockerfile.v0
<missing>      22 hours ago   COPY ./example-frontend . # buildkit            721kB     buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c adduser -D appuser # buildkit    4.87kB    buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c npm i -g serve && npm ci --on…   341MB     buildkit.dockerfile.v0
<missing>      22 hours ago   COPY ./example-frontend/package*.json . # bu…   693kB     buildkit.dockerfile.v0
<missing>      22 hours ago   RUN /bin/sh -c mkdir ./build # buildkit         0B        buildkit.dockerfile.v0
<missing>      12 days ago    WORKDIR /usr/src/app                            0B        buildkit.dockerfile.v0
<missing>      8 weeks ago    /bin/sh -c #(nop)  CMD ["node"]                 0B
<missing>      8 weeks ago    /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
<missing>      8 weeks ago    /bin/sh -c #(nop) COPY file:4d192565a7220e13…   388B
<missing>      8 weeks ago    /bin/sh -c apk add --no-cache --virtual .bui…   7.77MB
<missing>      8 weeks ago    /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.19     0B
<missing>      8 weeks ago    /bin/sh -c addgroup -g 1000 node     && addu…   102MB
<missing>      8 weeks ago    /bin/sh -c #(nop)  ENV NODE_VERSION=16.20.0     0B
<missing>      8 weeks ago    /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>      8 weeks ago    /bin/sh -c #(nop) ADD file:9a4f77dfaba7fd2aa…   7.05MB
```