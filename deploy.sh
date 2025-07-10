#!/bin/bash

# Stop and remove the container if it already exists
docker rm -f guvi-project-react-app 2>/dev/null || true

# Run the container
docker run -d --name guvi-project-react-app -p 80:80 srihariops/guvi_reactapp_prod:latest

