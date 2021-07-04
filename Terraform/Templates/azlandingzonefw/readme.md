This provisions a basic Azure deployment containing:
    -1 hub virtual network
    -N spoke virtual networks which peer to the hub (default: Shared and Apps vnets)
    -1 virtual machine in each vnet
    -Route tables for basic inter-vnet traffic
    -Azure firewall in hub network for routing and security, with log export to Log Analytics
    -Private DNS zone for address resolution across vnets

    Diagram can be found here:
    https://app.cloudskew.com/viewer/97de33ff-b521-476f-b34b-b90980d3deba