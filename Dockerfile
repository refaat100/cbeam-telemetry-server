FROM node:6

# Expose the HTTP port for OpenMCT
EXPOSE 8080
# Export the Websocket port for OpenMCT live telemetry
EXPOSE 8082

# Reduce npm install verbosity, overflows Travis CI log view
ENV NPM_CONFIG_LOGLEVEL warn

RUN mkdir -p /var/cbeam-telemetry-server
WORKDIR /var/cbeam-telemetry-server

COPY . /var/cbeam-telemetry-server

# Install MsgFlo and dependencies
RUN npm install --only=production

# Copy OpenMCT assets
RUN mkdir -p /var/cbeam-telemetry-server/node_modules/openmct
COPY node_modules/openmct /var/cbeam-telemetry-server/node_modules/openmct

# Map the volumes
VOLUME /var/cbeam-telemetry-server/config

CMD ./server.sh
