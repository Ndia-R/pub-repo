@echo off
setlocal enabledelayedexpansion

rem 目標ディレクトリの設定
set "target_dir=all-image"

rem 目標ディレクトリが存在しない場合は作成
if not exist "%target_dir%" mkdir "%target_dir%"

rem 現在のディレクトリ内のすべてのサブディレクトリをループ
for /d %%D in (*) do (
    rem "all-image"ディレクトリをスキップ
    if /i not "%%D"=="%target_dir%" (
        rem 各サブディレクトリ内のjpgファイルをコピー
        for %%F in ("%%D\*.jpg") do (
            copy "%%F" "%target_dir%\"
        )
    )
)

echo 全ての画像ファイルが %target_dir% にコピーされました。
pause
