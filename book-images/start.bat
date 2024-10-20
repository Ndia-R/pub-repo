@echo off
setlocal enabledelayedexpansion

echo バッチファイルの実行を開始します。

rem 目標ディレクトリの設定
set "target_dir=all-image"

echo 目標ディレクトリ: %target_dir%

rem 目標ディレクトリが存在しない場合は作成
if not exist "%target_dir%" (
    mkdir "%target_dir%"
    echo 目標ディレクトリを作成しました: %target_dir%
) else (
    echo 目標ディレクトリは既に存在します: %target_dir%
)

echo サブディレクトリの処理を開始します。

rem 現在のディレクトリ内のすべてのサブディレクトリをループ
for /d %%D in (*) do (
    rem "all-image"ディレクトリをスキップ
    if /i not "%%D"=="%target_dir%" (
        echo ディレクトリ %%D を処理中...
        rem 各サブディレクトリ内のjpgファイルをコピー
        for %%F in ("%%D\*.jpg") do (
            echo   ファイルをコピー中: %%F
            copy "%%F" "%target_dir%\"
            if errorlevel 1 (
                echo   エラー: %%F のコピーに失敗しました。
            ) else (
                echo   成功: %%F をコピーしました。
            )
        )
    )
)

echo 処理が完了しました。
echo 全ての画像ファイルが %target_dir% にコピーされました（エラーがあった場合は上記のメッセージを確認してください）。
pause