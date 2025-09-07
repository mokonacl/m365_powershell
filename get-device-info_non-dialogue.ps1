#初期値の登録
$TenantId = "<テナントID>"
$ClientId = "<アプリ登録のクライアントID>"
$ClientSecret_plain = "<アプリ登録で発行したクライアントシークレット>"
$scope = "https://graph.microsoft.com/.default"

#初期値の変換
$ClientSecret = ConvertTo-SecureString -String $ClientSecret_plain -AsPlainText -Force

#アクセストークン取得（MSAL認証）
$oauth = Get-MsalToken -ClientId $ClientId -TenantId $TenantId -ClientSecret $ClientSecret -Scopes $scope
$accessToken = ConvertTo-SecureString -String $oauth.AccessToken -AsPlainText -Force  

#Micorosoft Graph接続
Connect-MgGraph -AccessToken $accessToken 


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

$csvPath = "IntuneDevices_MacAddress.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Export csv:  $csvPath"
