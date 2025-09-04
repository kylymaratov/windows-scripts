Stop-Service -Name wuauserv -Force
Set-Service -Name wuauserv -StartupType Disabled
 
$services = @(
    "UsoSvc",           # Update Orchestrator
    "DiagTrack",        # Connected User Experiences
    "dmwappushsvc",     # Device Management
    "WaaSMedicSvc"      # Windows Update Medic
)

foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

  $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
if (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
New-ItemProperty -Path $regPath -Name "NoAutoUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null

 $telemetryServices = @(
    "DiagTrack",
    "dmwappushsvc"
)
foreach ($svc in $telemetryServices) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}
 