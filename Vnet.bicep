param vnet1Loc string = 'uksouth'
param VpnLoc string = 'uksouth'
param Vnet2Loc string = 'westus'
param Vnet3Loc string = 'centralus'

resource vnet1 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet1'
  location: vnet1Loc
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefix: '10.1.0.0/24'
        }
      }
     
      {
        name: 'vpnGateWaySubnet'
        properties: {
          addressPrefix: '10.33.33.0/24'
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet2'
  location: Vnet2Loc
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  
    subnets: [
      {
        name: 'Vnet2subnet'
        properties: {
          addressPrefix: '10.2.0.0/24'
        }
      }
    ]
  }
}

resource vnet3 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet3'
  location: Vnet3Loc
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
  
    subnets: [
      {
        name: 'Vnet2subnet'
        properties: {
          addressPrefix: '10.3.0.0/24'
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'vpnGatewayPublicIp'
  location: vnet1Loc
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource vpnGateWay 'Microsoft.Network/virtualNetworkGateways@2023-09-01'= {
	name: 'vpnGateway'
  location: VpnLoc
  properties: {
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw'
    }
    vpnType: 'RouteBased'
    ipConfigurations: [
      {
        name: 'gatewayIpConfig'
        properties: {
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: vnet1.properties.subnets[1].id
          }
        }
      }
    ]
  }
}


