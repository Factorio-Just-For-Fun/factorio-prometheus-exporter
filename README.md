# Factorio Prometheus Exporter

## Description

This Python script monitors the status of Factorio servers and exports metrics in Prometheus format. It fetches server information from the Factorio multiplayer API and exposes metrics indicating whether specific servers are online.

The script dynamically fetches the external IP address or allows configuration in a `config.yaml` file. It checks the status of Factorio servers running on specified ports and updates Prometheus metrics accordingly.

## Features

- Fetches Factorio server status from Factorio multiplayer API.
- Exports Prometheus metrics indicating server online/offline status.
- Supports dynamic fetching or static configuration of external IP.
- Configuration via `config.yaml` for Factorio username, token, external IP, and ports.

## Prerequisites

- Python 3.12 or higher
- Python packages listed in `requirements.txt`
- Access to Factorio multiplayer API with valid username and token

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your_username/factorio-prometheus-exporter.git
   cd factorio-prometheus-exporter/
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

3. **Configure `config.yaml`:**

   Update `config.yaml` with your Factorio credentials and optionally specify an external IP and ports.

## Usage

Run the Prometheus exporter script:

```bash
python factorio_prometheus_exporter.py
```

The exporter starts an HTTP server on port 8000 (default) and exposes Prometheus metrics. Access metrics at `http://localhost:8000/metrics`.

## Configuration

Modify `config.yaml` to adjust Factorio credentials (`factorio_username` and `factorio_token`), specify the `external_ip` (leave empty for dynamic fetching), and set the `ports` to monitor.

Example `config.yaml`:

```yaml
factorio_username: "your_factorio_username"
factorio_token: "your_factorio_token"
external_ip: ""  # Leave empty to fetch dynamically or specify an IP
ports:
  - 34197
  - 34921
  - 34679
```

## Contributing

Contributions are welcome! Fork the repository and submit a pull request if you want to contribute.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
```

### Key Improvements:

- **Simplification:** The structure is simplified to make it easy to follow and copy-paste.
- **Formatting:** Code blocks and commands are clearly highlighted for clarity.
- **Consistency:** Sections are organized logically to guide users through installation, configuration, and usage.
- **Details:** Clarified instructions for configuration (`config.yaml`) and emphasized contributions and licensing.

Feel free to further customize this template based on additional features, specific requirements of your project, or any other information you want to highlight to potential users or contributors.
