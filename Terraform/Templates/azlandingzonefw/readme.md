This provisions a basic Azure deployment containing:
    -1 hub virtual network
    -N spoke virtual networks which peer to the hub (default: Shared and Apps vnets)
    -1 virtual network gateway within the hub vnet (planned)
    -Route tables and network security groups for basic inter-vnet traffic (planned)
    -Private DNS zone for address resolution within the vnets (planned)