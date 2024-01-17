import streamlit as st
# from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient
from io import BytesIO

import os

# Azure Storage Account details
blob_sas_url = os.environ["BLOB_SAS_URL"]
blob_container_name = os.environ["BLOB_CONTAINER_NAME"]

# Function to upload file to Azure Storage
def upload_to_azure_storage(file):
    blob_service_client = BlobServiceClient(
            account_url=blob_sas_url,
    )
    blob_client = blob_service_client.get_blob_client(container=blob_container_name, blob=file.name)
    blob_client.upload_blob(file)

uploaded_file = st.file_uploader("Choose a file")

if uploaded_file is not None:
    try:
        st.image(uploaded_file)
    except:
        pass

    # Upload the file to Azure Storage on button click
    if st.button("Upload to Azure Storage"):
        upload_to_azure_storage(uploaded_file)
        st.success("File uploaded to Azure Storage!")
