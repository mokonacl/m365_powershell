#初期値の登録
$TenantId = "<テナントID>"
$ClientId = "<クライアントID>"
$thumbprint =　"<証明書の拇印>"

#Micorosoft Graph接続
 Connect-MgGraph -Clientid $ClientId -TenantId $TenantId -CertificateThumbprint $thumbprint

#以下実行処理
$devices = Get-MgDeviceManagementManagedDevice -All

$results = $devices | Select-Object `
    Id,
    DeviceName,
    UserDisplayName,
    OperatingSystem,
    ComplianceState,
    WiFiMacAddress,
    EthernetMacAddress,
    LastSyncDateTime

# 出力先をユーザのデスクトップに変更
$csvPath = Join-Path $env:USERPROFILE "\Desktop\IntuneDevices.csv"
$devices | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Export csv:  $csvPath"
