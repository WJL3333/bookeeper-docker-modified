# bookeeper-docker-modified

origin apache/bookeeper docker-compose.yml can't start a bookeeper cluster successfully

so i modified it reference https://github.com/sijie/bookkeeper/tree/5e9b85888a49b6110cf90ab0c010ea2ffe643dfb/docker/scripts


## how to use

1. build the docker image local

    ```shell
    sudo docker build -t apache/bookkeeper:4.9.2 .
    ```
    this Dockerfile download bookeeper-4.9.2 from a fixed site
    
    
    
    
2. start the bookeeper cluster

    ```shell
    sudo docker-compose up
    ```
