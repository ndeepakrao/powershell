# Get dates and create folder names
$Year = Get-Date -format "yyyy"
$MonthNumber = Get-Date -format "MM" 
$MonthName = (Get-Culture).DateTimeFormat.GetMonthName($MonthNumber)
$DayNumber = Get-Date -format "dd"
$DayName = Get-Date -format "dddd"
#write-host "$DayNumber $DayName"
$folderNameMonth = $MonthNumber+" "+$MonthName
$folderNameDay = $DayNumber+" "+$DayName
#$folderNameMonth = "02 February"
#$folderNameDay = "07 Thursday"

$directoryInfo = Get-ChildItem D:\Archive\$Year\$folderNameMonth | Measure-Object
$itemCount = $directoryInfo.count #Returns the count of all of the objects in the directory

if ($itemCount -ne 0){

#compress folders into .zip files
Compress-Archive -Path D:\Archive\$Year\$folderNameMonth\$folderNameDay -DestinationPath D:\Archive\$Year\$folderNameMonth\$folderNameDay

#Push files to IPA s3 bucket
aws s3 cp "D:\Archive\$Year\$folderNameMonth\$folderNameDay.zip" "s3://<Insert bucket name here>/<Insert sub-folder folder name>/$Year/$folderNameMonth/" --sse AES256 

#Delete folders
#rm -r -fo D:\Archive\$folderNameMonth
}
else {
    write-host "No folders to upload!"
}
