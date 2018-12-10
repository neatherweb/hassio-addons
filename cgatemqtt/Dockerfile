FROM homeassistant/amd64-base-python:3.6

ENV CONFIG_PATH=/data/options.json

# Install requirements for add-on
RUN apk add --no-cache jq git
#RUN apk add --no-cache curl 

RUN pip3 install git+https://github.com/neatherweb/cgatemqtt.git

RUN mkdir -p /etc/cgatemqtt

COPY run.sh /

RUN chmod a+x /run.sh

WORKDIR /

CMD /run.sh

