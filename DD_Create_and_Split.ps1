$DeleteSource = "a"
$Yes = @("Yes", "YES", "yes", "Y", "y")
$No = @("No", "NO", "no", "N", "n")

while(-not($Yes.contains($DeleteSource) -or $No.contains($DeleteSource))) {
	$DeleteSource = Read-Host -Prompt "Delete Source? [Y]es or [N]o"
}

$Games = Get-ChildItem -Path 'Games' -Filter *.iso

foreach($Game in $Games) {
    $GameWithPath = "Games\$Game"
    if($Game.name.length -gt 36) {
	$LongGame = $Game
        $ShortName = $LongGame.Name.Substring(0,36)
	Rename-Item $GameWithPath $ShortName
        $GameWithPath = "Games\$ShortName"
	$Game = Get-Item $GameWithPath
	Write-Host "$LongGame was renamed $Game"
    }
	
    $GameDD = $GameWithPath.Substring(0,$GameWithPath.Length-4) + "_DD.iso"
    $GameDDName = $GameDD.Substring(0,$GameDD.Length-4)
	
    ./dd.exe if=$GameWithPath of=$GameDD skip=387 bs=1M
    ./fSplit.exe -split 4094 mb "$GameDD" -f "$GameDDName.{0}.iso"
	
    Remove-Item $GameDD
    if($Yes.contains($DeleteSource)) {
    	Remove-Item -Recurse $GameWithPath
    }
}
