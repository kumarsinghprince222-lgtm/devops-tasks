# Day 4: Hybrid & On-Prem Connectivity Architecture

## 1. Architecture Overview & Traffic Flow
- **Source:** Azure VNet App Subnet (`10.0.1.0/24`) -> Python Connector (`10.0.1.4`)
- **DNS Resolution:** Azure Private DNS Zone (`internal.corp`) -> Resolves `sap-server.internal.corp` to `192.168.1.100`
- **Transit:** Azure Gateway Subnet (`10.0.0.0/27`) -> Site-to-Site IPsec VPN / ExpressRoute
- **Destination:** On-Premises SAP ERP (`192.168.1.100:3300`)

## 2. Connectivity Decision Matrix

| Option | Latency & SLA | Security | Cost Profile | Best Use Case |
| :--- | :--- | :--- | :--- | :--- |
| **Site-to-Site VPN** | Variable latency; 99.9% - 99.95% SLA | IPsec/IKE encrypted over public internet | Low (Gateway SKU + Egress) | Dev/Test, branch offices, failover path |
| **Azure ExpressRoute** | Ultra-low latency; 99.95% - 99.99% SLA | Private line; completely bypasses public internet | High (Port fees + provider circuit) | Mission-critical enterprise production (SAP) |
| **Hybrid Connections** | Moderate latency; 99.9% SLA | TLS 1.2 encrypted over outbound port 443 | Low (Included in App Service Plan) | Quick outbound TCP for App Services |

**Recommendation:** ExpressRoute for Primary Production SAP connectivity with Site-to-Site VPN as an active-passive failover.
