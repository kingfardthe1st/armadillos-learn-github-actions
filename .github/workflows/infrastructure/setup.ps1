$ErrorActionPreference = "Stop"

Install-Module Az.Resources -Force
Install-Module Az.Storage -Force
$ResourceGroupName = "$env:TF_VAR_resource_group_name"
$StorageAccountName = "learngitactionssa$env:TF_VAR_resource_suffix"
$Location = "East US"
$SkuName = "Standard_GRS"

Write-Host "Setting Up Pre-requisite Resources"
Write-Host "---------------------- Creating Resource Group ------------------"
New-AzResourceGroup -Name $ResourceGroupName -Location $Location
New-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -SkuName $SkuName -Location $Location

# Create a context object using Azure AD credentials
$StorageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -UseConnectedAccount
New-AzStorageContainer -Name "infrax" -Context $StorageContext