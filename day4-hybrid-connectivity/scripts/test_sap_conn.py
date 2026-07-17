import socket
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

SAP_HOST = "sap-server.internal.corp"
SAP_PORT = 3300  # Default SAP Gateway Port

def test_hybrid_connection():
    try:
        # Resolve Hostname via Private DNS
        ip_address = socket.gethostbyname(SAP_HOST)
        logging.info(f"DNS Resolution Success: {SAP_HOST} -> {ip_address}")

        # Test TCP Connectivity
        with socket.create_connection((ip_address, SAP_PORT), timeout=5):
            logging.info(f"TCP Connection Success: Connected to SAP on {SAP_HOST}:{SAP_PORT}")
            
    except socket.gaierror:
        logging.error(f"DNS Resolution Failed for {SAP_HOST}. Check Private DNS links.")
    except socket.timeout:
        logging.error(f"Connection Timed Out to {SAP_HOST}. Check Gateway routing/firewall rules.")
    except Exception as e:
        logging.error(f"Connection Error: {str(e)}")

if __name__ == "__main__":
    test_hybrid_connection()
