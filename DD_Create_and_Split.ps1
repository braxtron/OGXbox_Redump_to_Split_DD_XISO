$DeleteSource = "a"
$Yes = @("Yes", "YES", "yes", "Y", "y")
$No = @("No", "NO", "no", "N", "n")

while(-not($Yes.contains($DeleteSource) -or $No.contains($DeleteSource))) {
	$DeleteSource = Read-Host -Prompt "Delete Source? [Y]es or [N]o"
}

$Games = Get-ChildItem -Path 'Games' -Filter *.iso

foreach($Game in $Games) {
	$GameName = $Game.BaseName
	if($GameName.length -gt 36) {
        $GameName = $Game.Name.Substring(0,36)
	}
	
    $GameDD = "Games\" + $GameName + "_DD.iso"
    ./dd.exe if=Games\$Game of=$GameDD skip=1k bs=387k
 	./fSplit.exe -split 4094 mb "$GameDD" -f "Games\$GameName.{0}.iso"
	
	Remove-Item $GameDD
	if($Yes.contains($DeleteSource)) {
		Remove-Item Games\$Game
	}
}
