FROM ubuntu:20.04

WORKDIR /svc

RUN apt-get update && apt-get install -y fortune cowsay netcat

ENV PATH $PATH:/usr/games

COPY wisecow.sh /svc/wisecow.sh

RUN chmod +x /svc/wisecow.sh

EXPOSE 4499

CMD ["/svc/wisecow.sh"]
