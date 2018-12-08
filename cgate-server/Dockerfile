# escape=`
FROM homeassistant/amd64-base:latest

ENV CONFIG_PATH=/data/options.json

# Install requirements for add-on
RUN apk add --no-cache jq
RUN apk add --no-cache openjdk8
RUN apk add --no-cache curl 

RUN mkdir -p /config/cgate

RUN mkdir -p /app `
    && curl -o /app/cgate.zip https://updates.clipsal.com/ClipsalSoftwareDownload/mainsite/cis/technical/CGate/cgate-2.11.4_3251.zip `
    && unzip /app/cgate.zip -d /app/ `
    && rm /app/cgate.zip `
    && chmod 755 /app/cgate/cgate.sh `
    && bash -c "sed $'s/\r//' -i /app/cgate/cgate.sh"

RUN echo 'interface 0:0:0:0:0:0:0:1 Program' >> /app/cgate/config/access.txt `
    && echo 'interface 127.0.0.1 Program' >> /app/cgate/config/access.txt `
    && echo 'interface localhost Program' >> /app/cgate/config/access.txt `
    && echo 'remote 255.255.255.255 Program' >> /app/cgate/config/access.txt

COPY run.sh /

RUN chmod a+x /run.sh

WORKDIR /app/cgate

CMD /run.sh

