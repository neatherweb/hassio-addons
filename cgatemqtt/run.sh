CONFIG_PATH=/data/options.json

LOG_CONF="/etc/cgatemqtt/logging.conf"
SERVER_CONF="/etc/cgatemqtt/server.conf"

LOG_LEVEL=$(jq --raw-output '.log_level' $CONFIG_PATH)
CGATE_HOST=$(jq --raw-output '.cgate.host' $CONFIG_PATH)
CGATE_PROJECT=$(jq --raw-output '.cgate.project' $CONFIG_PATH)
CGATE_NETWORK=$(jq --raw-output '.cgate.network' $CONFIG_PATH)
MQTT_HOST=$(jq --raw-output '.mqtt.host' $CONFIG_PATH)
MQTT_PORT=$(jq --raw-output '.mqtt.port' $CONFIG_PATH)
MQTT_USER=$(jq --raw-output '.mqtt.user' $CONFIG_PATH)
MQTT_PASSWORD=$(jq --raw-output '.mqtt.password' $CONFIG_PATH)
FAN_LIST=$(jq --raw-output -c '.lighting.fans' $CONFIG_PATH)

create_logging() {
	(cat <<END
[loggers]
keys=root,CGateMQTTServer

[handlers]
keys=consoleHandler

[formatters]
keys=simpleFormatter

[logger_root]
level=$LOG_LEVEL
handlers=consoleHandler

[logger_CGateMQTTServer]
level=$LOG_LEVEL
handlers=consoleHandler
qualname=CGateMQTTServer
propagate=0

[handler_consoleHandler]
class=StreamHandler
level=$LOG_LEVEL
formatter=simpleFormatter
args=(sys.stdout,)

[formatter_simpleFormatter]
format=%(asctime)s - %(name)s - %(levelname)s - %(message)s
datefmt=
END
) > $LOG_CONF
}

create_server_conf() {
	(cat <<END
[logging]
config = $LOG_CONF

[cgate]
host = $CGATE_HOST
project = $CGATE_PROJECT
network = $CGATE_NETWORK

[mqtt]
host = $MQTT_HOST
port = $MQTT_PORT
user = $MQTT_USER
password = $MQTT_PASSWORD

[lighting]
fans = $FAN_LIST
END
) > $SERVER_CONF
}

create_logging
create_server_conf
cgatemqtt -c $SERVER_CONF
