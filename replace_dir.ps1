$index = 0 

$origin_dir = $Args[$index++] 
$replace_dir = $Args[$index++]
$replace_map = $Args[$index++]

# 置換先に物がある場合削除
if(Test-Path -Path $replace_dir) {
    Remove-Item -Path $replace_dir -Recurse 
}

# 置換後のフォルダ一式を作成。 
Copy-Item $origin_dir $replace_dir -Recurse 

$list = Get-ChildItem $replace_dir -Recurse 
foreach ($item in $list) { 
    if(-not($item.PSIsContainer)) { 
        # ファイルの場合のみ置換処理実行。 
        .\replace_file.ps1 $item.FullName $item.FullName $replace_map 
    } 
} 