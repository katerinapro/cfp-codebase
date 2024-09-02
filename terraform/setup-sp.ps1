# Ensure Azure CLI is installed
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Error "Azure CLI is not installed. Please install Azure CLI and try again."
    exit 1
}

# Variables
$spName = "terraform-sp"
$role = "Contributor"
$subscriptionId = "69673b12-ff56-46f2-b9b2-0eb6a7002b33"

# Create Service Principal
Write-Output "Creating Service Principal with Azure CLI..."
az login
$spOutput = az ad sp create-for-rbac --name $spName --role $role --scopes "/subscriptions/$subscriptionId" --query "{appId:appId, password:password, tenant:tenant}" --output json

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create Service Principal. Ensure Azure CLI is properly configured."
    exit 1
}

# Parse output
$sp = $spOutput | ConvertFrom-Json
$appId = $sp.appId
$password = $sp.password
$tenantId = $sp.tenant

# Set environment variables
Write-Output "Setting environment variables..."
[System.Environment]::SetEnvironmentVariable("ARM_SUBSCRIPTION_ID", $subscriptionId, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("ARM_CLIENT_ID", $appId, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("ARM_CLIENT_SECRET", $password, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("ARM_TENANT_ID", $tenantId, [System.EnvironmentVariableTarget]::User)

# Output the values for the user to confirm
Write-Output "Environment variables have been set:"
Write-Output "ARM_SUBSCRIPTION_ID = $subscriptionId"
Write-Output "ARM_CLIENT_ID = $appId"
Write-Output "ARM_CLIENT_SECRET = $password"
Write-Output "ARM_TENANT_ID = $tenantId"

# Instructions for granting API permissions
Write-Output "To grant Microsoft Graph API permissions:"
Write-Output "1. Open the Azure Portal (https://portal.azure.com)."
Write-Output "2. Navigate to 'Azure Active Directory' > 'App registrations'."
Write-Output "3. Find and select the application with the App ID: $appId."
Write-Output "4. Go to 'API permissions' > 'Add a permission'."
Write-Output "5. Select 'Microsoft Graph' > 'Application permissions'."
Write-Output "6. Add the permissions 'Application.ReadWrite.All' and 'AppRoleAssignment.ReadWrite.All'."
Write-Output "7. Click on 'Grant admin consent for [Your Organization]'."

Write-Output "Script completed. Please follow the instructions above to complete the setup."
