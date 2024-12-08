// import base64
// import codecs
// import json
// import requests
// import time
// import datetime
//
// #REST_HOST = 'mybitnet.com:8443'
// REST_HOST = '54.90.204.167:8443'
// MACAROON_PATH = './pythonfunctions/keys/lnd_admin.macaroon'
// TLS_PATH = './pythonfunctions/keys/fullchain.pem'
//
// def call_server():
// url = f'https://{REST_HOST}/v1/state'
// while True:
// r = requests.get(url, verify=False)
// current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
// print(f"[{current_time}] {r.json()}")
// #print(f"Response: {r.text}")
// time.sleep(1)
//
// # Wait for the user to hit enter
// input("Press Enter to start calling the server every 1 second...")
//
// # Start calling the server
// call_server()
