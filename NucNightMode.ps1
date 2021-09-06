#NIGHT MODE

#Sets Night Var to False
$Night = "False"

#Sets Time
$Time = Get-Date -Format "HH"


#Checks Time and Sets Night Var

#
#Change the "19" to the 24 hour format hour 
#E.g 19 for 7pm or 20 for 8pm
#

if ($Time -gt "19") {
$Night = "True"
Write-Host "GT19"

#
#Change the "07" to the 24 hour format hour
#E.g 07 for 7am or 08 for 8am
#

}elseif ($Time -lt "07") {
$Night = "True"
Write-Host "LT7"
}else {
$Night = "False"
}
$Night



#LED CONTROL CODE

$lookup = @{
      '0%' = 0
      '1%' = 0x100
      '5%' = 0x500 
      '10%' = 0xa00
      '25%' = 0x1900
      '50%' = 0x3200
      '75%' = 0x4b00
      '100%' = 0x6400
 
      "On" = 0x40000
      "1Hz blink" = 0x10000
      "0.5Hz blink" = 0x50000
      "0.25Hz blink" = 0x20000
      "1Hz fade" = 0x30000
      "0.5Hz fade" = 0x70000
      "0.25Hz fade" = 0x60000
 
      Disable = 0
      Cyan   = 0x1000000
      Pink  = 0x2000000
      Yellow = 0x3000000
      Blue = 0x4000000
      Red = 0x5000000
      Green = 0x6000000
      White = 0x7000000
}
$inpb = @(0x2, 0x0, 0x40000, 0x0)

#Check if Night 


#If Night True, set to 1%
#Else Set to 100%

#
#Change 1% to any of the brightness values above
# 
if ($Night -eq "True") {
$inpb[1] = "1%"  
$inpb[1] = $lookup[$inpb[1]]

#
#Change 100% to any of the brightness values above
#

}else {
$inpb[1] = "100%"  
$inpb[1] = $lookup[$inpb[1]]
}

#You can change to any of the fade/flash modea above
$inpb[2] = "On"
$inpb[2] = $lookup[$inpb[2]]
#You can change to any of the colours abobe 
$inpb[3] = "White"
$inpb[3] = $lookup[$inpb[3]] 
$cmd = [uint32]($inpb[0] + $inpb[1] + $inpb[2] + $inpb[3])
$led = Get-CimInstance cisd_wmi -Namespace "root\wmi"
Invoke-CimMethod -InputObject $led -MethodName setState -Arguments @{cmd=$cmd}