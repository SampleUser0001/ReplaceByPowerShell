# 置換マップファイルの読み込み 
$replace_table = @{} 

$replace_map = Get-Content $Args[2] 

foreach($line in $replace_map) { 
    $splited = $line -split "\t" 
    $replace_table.Add($splited[0],$splited[1]) 
}

# 元ファイル取得
$str = Get-Content $Args[0] -Raw 

# 置換
foreach($key in $replace_table.Keys) { 
    $str = $str.replace($key, $replace_table[$key])
}

# 出力先のファイルパス取得
$export_filepath = $Args[1] 

# 出力先のディレクトリがない場合は作成する。
$export_dir = Split-Path $export_filepath -Parent
if (-not(Test-Path $export_dir)) { 
    mkdir $export_dir
} 

# ファイル書き込み
Set-Content -Path $export_filepath -Value $str -NoNewline