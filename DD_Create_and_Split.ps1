$DeleteSource = "a"
$ExpandArchives = "a"
$Yes = @("Yes", "YES", "yes", "Y", "y")
$No = @("No", "NO", "no", "N", "n")

while(-not($Yes.contains($ExpandArchives) -or $No.contains($ExpandArchives))) {
	$ExpandArchives = Read-Host -Prompt "Find and expand ZIP archives to Games folder? [Y]es or [N]o"
}

while(-not($Yes.contains($DeleteSource) -or $No.contains($DeleteSource))) {
	$DeleteSource = Read-Host -Prompt "Delete Source ISOs after processing? [Y]es or [N]o"
}

if($Yes.contains($ExpandArchives)) {
	$Zips = Get-ChildItem -Path 'Games' -Filter *.zip -Recurse

	foreach($zip in $Zips) {
		write-output "Trying to expand archive: $($zip.FullName)"
		Expand-Archive -LiteralPath $zip.FullName -DestinationPath "Games" -Force
	}
}

$Games = Get-ChildItem -Path 'Games' -Filter *.iso

foreach($Game in $Games) {
	write-output "Processing $Game"
	$GameName = $Game.BaseName
	if($GameName.length -gt 36) {
        $GameName = $Game.Name.Substring(0,36)
		write-output "Truncating filename to: $GameName"
	}
	
    $GameDD = "Games\" + $GameName + "_DD.iso"
    & "$PSScriptRoot\dd.exe" @("if=Games\$Game", "of=$GameDD", "skip=387", "bs=1M")
 	& "$PSScriptRoot\fSplit.exe"  @('-split', 4094, 'mb', $GameDD, '-df', 'Games', '-f', "$GameName.{0}.iso")
	
	Remove-Item $GameDD
	if($Yes.contains($DeleteSource)) {
		Remove-Item Games\$Game
	}
}
