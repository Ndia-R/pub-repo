@echo off
chcp 65001 >nul

rem 新しいフォルダを作成（既に存在する場合は無視）
if not exist "all-image" (
    mkdir "all-image"
    echo Created "all-image" folder.
) else (
    echo "all-image" folder already exists.
)

rem 画像ファイルをコピーする
setlocal enabledelayedexpansion

rem カウンタの初期化
set "success_count=0"
set "failure_count=0"
set "total_count=0"

rem 各サブディレクトリをループ
for /r %%d in (.) do (
    rem サブディレクトリ内のjpgファイルをループ
    for %%f in ("%%d\*.jpg") do (
        
        rem ファイル名から「」を取り除く
        set "filename=%%~nxf"
        set "filename=!filename:「=!"
        set "filename=!filename:」=!"
        
        rem コピー処理
        copy "%%f" "all-image\!filename!" >nul
        
        rem コピー結果を確認
        if errorlevel 1 (
            echo Error copying "%%f" to
            set /a failure_count+=1
        ) else (
            echo Successfully copied: "%%f"
            set /a success_count+=1
        )
        
        set /a total_count+=1
    )
)

rem 最終結果を表示
echo.
echo Copy Summary:
echo Total files processed: !total_count!
echo Successful copies: !success_count!
echo Failed copies: !failure_count!

pause
