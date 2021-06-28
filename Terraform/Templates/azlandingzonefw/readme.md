This provisions a basic Azure deployment containing:
    -1 hub virtual network
    -N spoke virtual networks which peer to the hub (default: Shared and Apps vnets)
    -Route tables and network security groups for basic inter-vnet traffic
    -Azure firewall in hub network for routing and security
    -Private DNS zone for address resolution within the vnets (planned)