#!/bin/sh
# Quickly build and deploy this to my private Dockerhub
docker build -t ghaering/streamlit-azure-upload .
docker push ghaering/streamlit-azure-upload
