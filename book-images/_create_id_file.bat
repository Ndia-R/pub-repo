@echo off
setlocal enabledelayedexpansion

REM スクリプトが配置されているディレクトリを取得
set scriptDir=%~dp0

REM CSVファイルの相対パスを指定
set csvFile=%scriptDir%_data.csv

REM 一時的なPowerShellスクリプトを作成
set tempPSScript=%scriptDir%temp_script.ps1

REM PowerShellスクリプトの内容を一時ファイルに書き込む
echo $scriptDir = "%scriptDir%" > "%tempPSScript%"
echo $csvFile = "%csvFile%" >> "%tempPSScript%"
echo $csvData = Import-Csv -Path $csvFile -Header "ID", "タイトル" >> "%tempPSScript%"
echo $createCount = 0 >> "%tempPSScript%"
echo $notFoundCount = 0 >> "%tempPSScript%"
echo foreach ($row in $csvData) { >> "%tempPSScript%"
echo $id = $row.ID >> "%tempPSScript%"
echo $title = $row.タイトル >> "%tempPSScript%"
echo $originalFile = Join-Path -Path $scriptDir -ChildPath "「$title」.jpg" >> "%tempPSScript%"
echo $idFile = Join-Path -Path $scriptDir -ChildPath "$id.jpg" >> "%tempPSScript%"
echo if (Test-Path -Path $originalFile) { >> "%tempPSScript%"
echo Copy-Item -Path $originalFile -Destination $idFile >> "%tempPSScript%"
echo $createCount++ >> "%tempPSScript%"
echo } else { >> "%tempPSScript%"
echo Write-Host "ファイルが見つかりません: $id 「$title」" >> "%tempPSScript%"
echo $notFoundCount++ >> "%tempPSScript%"
echo } >> "%tempPSScript%"
echo } >> "%tempPSScript%"
echo Write-Host "作成したファイル数: $createCount" >> "%tempPSScript%"
echo Write-Host "見つからなかったファイル数: $notFoundCount" >> "%tempPSScript%"

REM PowerShellスクリプトを実行
powershell -ExecutionPolicy Bypass -File "%tempPSScript%"

REM 一時的なPowerShellスクリプトを削除
del "%tempPSScript%"

REM キーを押すまで待機
pause

endlocal
