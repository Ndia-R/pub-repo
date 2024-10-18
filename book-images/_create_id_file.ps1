# スクリプトが配置されているディレクトリを取得
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# CSVファイルの相対パスを指定
$csvFile = Join-Path -Path $scriptDir -ChildPath "_data.csv"

# CSVファイルを読み込み
$csvData = Import-Csv -Path $csvFile -Header "ID", "タイトル"

$createCount = 0
$notFoundCount = 0

foreach ($row in $csvData) {
    $id = $row.ID
    $title = $row.タイトル

    $originalFile = Join-Path -Path $scriptDir -ChildPath "「$title」.jpg"
    $idFile = Join-Path -Path $scriptDir -ChildPath "$id.jpg"

    if (Test-Path -Path $originalFile) {
        Copy-Item -Path $originalFile -Destination $idFile
        $createCount++
    } else {
        Write-Host "ファイルが見つかりません: $id 「$title」"
        $notFoundCount++
    }
}

Write-Host "作成したファイル数: $createCount"
Write-Host "見つからなかったファイル数: $notFoundCount"
Pause
