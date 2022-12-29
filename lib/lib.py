import requests
import zipfile
import os

def download_nopecha():
    # Download the latest unpacked NopeCHA extension.
    # Undetected chromedriver does not support loading from a crx file.
    with open('chrome.zip', 'wb') as f:
        f.write(requests.get('https://nopecha.com/f/chrome.zip').content)
    with zipfile.ZipFile('chrome.zip', 'r') as zip_ref:
        zip_ref.extractall('nopecha')
    args_data1 = f"--disable-extensions-except={os.getcwd()}/nopecha"
    args_data2 = f"--load-extension={os.getcwd()}/nopecha"
    return [args_data1,args_data1]

