FROM  airdock/oraclejdk:1.8
COPY ./target/addax/addax-* /opt/addax/

WORKDIR /opt/addax

RUN chmod 755 /opt/addax/bin/*

