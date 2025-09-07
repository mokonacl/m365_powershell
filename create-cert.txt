#証明書の作成
$mycert = New-SelfSignedCertificate -Subject "GraphPowerShellApp" `
   -CertStoreLocation "cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(1) `
   -KeyExportPolicy Exportable -KeySpec Signature

#エクスポート（CERファイル）
$mycert | Export-Certificate -FilePath ".\mycert1.cer"

#作成した証明書の拇印
$mycert | Select Thumbprint
