FROM ubuntu 
RUN apt-get update && \
    apt-get -y install cowsay
    
RUN export PATH=$PATH:/usr/games

ENTRYPOINT [ "cowsay"]
