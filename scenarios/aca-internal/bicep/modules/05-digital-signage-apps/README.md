# Deploy the Hello World sample container app

Your [application platform](../04-container-apps-environment/README.md) is now ready to accept workloads. You can deploy a sample "hello world"-style application to see the application platform perform its hosting duties.

## Expected results

A container app using the Hello World sample app is deployed to the Container Apps Environment.

### Public content warning

Public container registries are subject to faults such as outages or request throttling. Interruptions like these can be crippling for a system that needs to pull an image right now. To minimize the risks of using public registries, store all applicable container images in a registry that you control, such as the SLA-backed Azure Container Registry that is deployed with this architecture. For simplicity in this walkthrough, the following deployment will be pulling directly from `mcr.microsoft.com/azuredocs/containerapps-helloworld:latest`.

### Resources

- A container app based on the Hello World sample

## Steps


1. Decide if you want to deploy this sample workload.

   You can stop at this point if you're interested only in the infrastructure components. If you'd like to skip workload deployment please remember to [:broom: clean up](../../README.md#broom-clean-up-resources) your resources when you are done.

1. Deploy the Hello World container app.

   ```bash
   RESOURCENAME_RESOURCEGROUP_SPOKE=DSS_DEV_RG
   RESOURCEID_IDENTITY_ACR=/subscriptions/506efc48-f9da-4250-9195-014c00614790/resourcegroups/DSS_DEV_RG/providers/Microsoft.ManagedIdentity/userAssignedIdentities/dss-user-assigned-mi-dev
   RESOURCEID_ACA=/subscriptions/506efc48-f9da-4250-9195-014c00614790/resourceGroups/DSS_DEV_RG/providers/Microsoft.App/managedEnvironments/cae-lzaaca-dev-eus
   echo RESOURCENAME_RESOURCEGROUP_SPOKE: $RESOURCENAME_RESOURCEGROUP_SPOKE && \
   echo RESOURCEID_IDENTITY_ACR: $RESOURCEID_IDENTITY_ACR && \
   echo RESOURCEID_ACA: $RESOURCEID_ACA
   ```

1. Build a sample image using the jumpbox or a computer that has access to the private network. If using a jumpbox, you will need a linux one and install docker into it, then run docker build on your application code and docker push to your container registry. Then Update your deploy.hello-world.parameters.jsonc file with the required information. We have provided a sample app in the sample_app_code folder with its docker file.
1. Note: The az acr build command wont work here unless you configure a [dedicated agent pool within your vnet to run tasks](https://learn.microsoft.com/en-us/azure/container-registry/tasks-agent-pools)


   ```bash
   # [This takes about one minute to run.] 
   az deployment group create \
      -n digital-signage-apps \
      -g $RESOURCENAME_RESOURCEGROUP_SPOKE \
      -f 05-digital-signage-apps/digital-signage-apps.bicep \
      -p 05-digital-signage-apps/digital-signage-apps.parameters.jsonc \
      -p containerRegistryUserAssignedIdentityId=${RESOURCEID_IDENTITY_ACR} containerAppsEnvironmentId=${RESOURCEID_ACA}
   ```

## Next step

You can stop here or proceed to next step if you want to use app gateway to expose the app externally.. **This will require you have a app gateway subnet.**

:arrow_forward: [Expose the workload through Application Gateway](../06-application-gateway/README.md)
