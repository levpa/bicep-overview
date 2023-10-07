# deployment with PowerShell
Connect-AzAccount

New-AzResourceGroupDeployment -ResourceGroupName bicep-course -TemplateFile main.bicep -Name powershell-deployment