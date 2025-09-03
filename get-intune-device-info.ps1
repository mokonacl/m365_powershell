# Graph PowerShell SDK 
# Install-Module Microsoft.Graph -Scope CurrentUser

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

$devices = Get-MgDeviceManagementManagedDevice -All

$results = $devices | Select-Object `
    DeviceName,
    UserDisplayName,
    OperatingSystem,
    ComplianceState,
    WiFiMacAddress,
    EthernetMacAddress

echo $results

$csvPath = "IntuneDevices_MacAddress.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "csv export: $csvPath"