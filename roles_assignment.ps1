param (
    [string]$subscriptionId,
    [string]$resourceGroupName
)

$vmName = "airflow"
$storageAccountName = "kafkastockdata1"
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageAccountResourceId = $storageAccount.Id
New-AzRoleAssignment -ObjectId $vm.Identity.PrincipalId -RoleDefinitionName "Contributor" -Scope $storageAccountResourceId
$vmName = "airflow"
$storageAccountName = "kafkastockdata1"
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageAccountResourceId = $storageAccount.Id
New-AzRoleAssignment -ObjectId $vm.Identity.PrincipalId -RoleDefinitionName "Storage Blob Data Contributor" -Scope $storageAccountResourceId
$vmName = "airflow"
$amlWorkspaceName = "mlserving"
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
$amlWorkspace = Get-AzResource -ResourceGroupName $resourceGroupName -ResourceType "Microsoft.MachineLearningServices/workspaces" -Name $amlWorkspaceName
$amlWorkspaceResourceId = $amlWorkspace.ResourceId
 New-AzRoleAssignment -ObjectId $vm.Identity.PrincipalId -RoleDefinitionName "Contributor" -Scope $amlWorkspaceResourceId
