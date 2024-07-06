import requests
from prometheus_client import start_http_server, Gauge
import time
import yaml

# Function to get the external IP address dynamically
def get_external_ip():
    try:
        response = requests.get('https://httpbin.org/ip')
        if response.status_code == 200:
            ip_info = response.json()
            return ip_info['origin']
        else:
            print("Failed to fetch external IP. Status code:", response.status_code)
            return None
    except Exception as e:
        print("An error occurred while fetching external IP:", e)
        return None

# Load configuration from config.yaml
try:
    with open('config.yaml', 'r') as f:
        config = yaml.safe_load(f)
except yaml.YAMLError as e:
    print(f"Error loading YAML from config file: {e}")
    raise

FACTORIO_USERNAME = config['factorio_username']
FACTORIO_TOKEN = config['factorio_token']
EXTERNAL_IP = config.get('external_ip', '')  # Get external_ip from config or default to empty string
PORTS = config['ports']

# Fetch external IP dynamically if not specified in config
if not EXTERNAL_IP:
    EXTERNAL_IP = get_external_ip()

if EXTERNAL_IP is None:
    raise ValueError("Failed to fetch external IP. Check network connectivity or try again later.")

# URL to fetch the online servers
url = f'https://multiplayer.factorio.com/get-games?username={FACTORIO_USERNAME}&token={FACTORIO_TOKEN}'

# Prometheus metrics
factorio_server_statuses = {
    f"{EXTERNAL_IP}_{port}": Gauge(f'factorio_server_online_{EXTERNAL_IP.replace(".", "_")}_{port}', f'Whether the Factorio server {EXTERNAL_IP}:{port} is online')
    for port in PORTS
}

# Function to check if the Factorio server is online
def check_server_status():
    try:
        response = requests.get(url)
        if response.status_code == 200:
            games = response.json()

            # Initialize status for each port
            for port in PORTS:
                factorio_server_statuses[f"{EXTERNAL_IP}_{port}"].set(0)  # Default to 0 (offline)

            # Check if any of the servers match the external IP and ports in the list
            for game in games:
                host_address = game.get('host_address')
                if not host_address:
                    continue
                server_ip, server_port = host_address.split(':')
                server_port = int(server_port)

                if server_ip == EXTERNAL_IP and server_port in PORTS:
                    print(f"Server {EXTERNAL_IP}:{server_port} is online:", game)
                    factorio_server_statuses[f"{EXTERNAL_IP}_{server_port}"].set(1)  # Set to 1 (online)

        else:
            print("Failed to fetch data. Status code:", response.status_code)
            for port in PORTS:
                factorio_server_statuses[f"{EXTERNAL_IP}_{port}"].set(0)  # Set all to 0 (offline)
    except Exception as e:
        print("An error occurred:", e)
        for port in PORTS:
            factorio_server_statuses[f"{EXTERNAL_IP}_{port}"].set(0)  # Set all to 0 (offline)

if __name__ == '__main__':
    # Start up the server to expose the metrics.
    start_http_server(8000)
    # Generate some requests.
    while True:
        check_server_status()
        time.sleep(10)  # Check every 10 seconds
