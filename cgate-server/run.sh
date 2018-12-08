CONFIG_PATH=/data/options.json

CBUS_PROJ_NAME=$(jq --raw-output '.project' $CONFIG_PATH)

echo "project.default.dir=/config/cgate/" > /app/cgate/config/C-GateConfig.txt 
echo "project.start=$CBUS_PROJ_NAME" >> /app/cgate/config/C-GateConfig.txt

/app/cgate/cgate.sh
