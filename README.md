# bookeeper-docker-modified

origin apache/bookeeper docker-compose.yml can't start a bookeeper cluster successfully

so i modified it on my own


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
