param digitalSignageContentBroker string = 'digital-signage-content-broker'
param digitalSignageContentBrokerImage string = 'dsscontainerregistrydev.azurecr.io/wmata/digital-signage-content-broker:1.0.1'
param containerAppsEnvironmentId string
param containerRegistryUserAssignedIdentityId string

param digitalSignageKioskApp string = 'digital-signage-kiosk-app'
param digitalSignageKioskAppImage string = 'dsscontainerregistrydev.azurecr.io/wmata/digital-signage-kiosk-app:1.0.1'

param digitalSignageStationsAheadApp string = 'digital-signage-stations-ahead'
param digitalSignageStationsAheadAppImage string = 'dsscontainerregistrydev.azurecr.io/wmata/digital-signage-stations-ahead-app:1.0.1'

param tags object

module digitalSignageContentBrokerModule 'deploy.digital-signage-apps.module.bicep' = {
  name: digitalSignageContentBroker
  params: {
    containerAppsEnvironmentId: containerAppsEnvironmentId
    containerName: digitalSignageContentBroker
    containerRegistryUserAssignedIdentityId: containerRegistryUserAssignedIdentityId
    image: digitalSignageContentBrokerImage
    tags: tags
  }
}

module digitalSignageKioskAppModule 'deploy.digital-signage-apps.module.bicep' = {
  name: digitalSignageKioskApp
  params: {
    containerAppsEnvironmentId: containerAppsEnvironmentId
    containerName: digitalSignageKioskApp
    containerRegistryUserAssignedIdentityId: containerRegistryUserAssignedIdentityId
    image: digitalSignageKioskAppImage
    tags: tags
  }
}

module digitalSignageStationsAheadAppModule 'deploy.digital-signage-apps.module.bicep' = {
  name: digitalSignageStationsAheadApp
  params: {
    containerAppsEnvironmentId: containerAppsEnvironmentId
    containerName: digitalSignageStationsAheadApp
    containerRegistryUserAssignedIdentityId: containerRegistryUserAssignedIdentityId
    image: digitalSignageStationsAheadAppImage
    tags: tags
    environmentVars: [{
      name: 'ANC_FEED'
      value: 'ws://10.10.85.5:8080/ws?useCompression=true'
    }]
  }
}
