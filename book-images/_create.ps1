# _create_id_file.ps1

# 作業ディレクトリのパスを設定
$rootDir = Get-Location

# IDファイルを格納するディレクトリのパスを設定
$idFilesDir = Join-Path -Path $rootDir -ChildPath "id-files"

# IDファイル用のディレクトリを作成（すでに存在する場合は無視）
if (-not (Test-Path -Path $idFilesDir)) {
    New-Item -ItemType Directory -Path $idFilesDir
}

# CSVファイルのパスを設定
$csvFilePath = Join-Path -Path $rootDir -ChildPath "_data.csv"

# CSVファイルの内容をインポート
$data = Import-Csv -Path $csvFilePath -Header ID, Title, Ignore

# 成功数、失敗数、合計数を初期化
$successCount = 0
$failureCount = 0
$totalCount = $data.Count

# 各エントリに対して処理を実行
foreach ($entry in $data) {
    $title = $entry.Title
    $id = $entry.ID

    # JPGファイルのパスを作成
    $jpgFilePath = Join-Path -Path $rootDir -ChildPath "$title.jpg"

    # 新しいファイル名のパスを作成
    $newJpgFilePath = Join-Path -Path $idFilesDir -ChildPath "$id.jpg"

    # ファイルが存在するか確認
    if (Test-Path -Path $jpgFilePath) {
        # 新しいファイルをコピー
        Copy-Item -Path $jpgFilePath -Destination $newJpgFilePath
        Write-Host "$title : $id.jpg"
        $successCount++
    } else {
        Write-Host "File not found: $jpgFilePath"
        $failureCount++
    }
}

# 結果を表示
Write-Host "OK: $successCount"
Write-Host "NG: $failureCount"
Write-Host "Total: $totalCount"
