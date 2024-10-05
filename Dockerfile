FROM postgres:16 AS pg

WORKDIR /root

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/pksunkara/pgx_ulid/releases/download/v0.1.5/pgx_ulid-v0.1.5-pg16-amd64-linux-gnu.deb
RUN dpkg -i pgx_ulid-v0.1.5-pg16-amd64-linux-gnu.deb

CMD ["postgres"]
