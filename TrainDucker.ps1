# Train Ducker
# Written by Matthew A. Cordaro

# You may need to change the location of chrome for your computer.
$chromeLoc = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'

# Verify arguments, if any
$startingNum = $args[0]
if ($startingNum){
  if ($startingNum.getType().name.CompareTo("Int32")){
    Write-Host "Not a number." 
    Exit
  }
  if ($startingNum -lt 1000 -or $startingNum -gt 9999){
    Write-Host "Not between 1000 & 9999." 
    Exit
  }
} else {
  $startingNum = 1000
}
if ($startingNum -eq 1000){
  Write-Host "Welcome to the Train Ducker Script!"
  Write-Host "The goal of the Google Images Train Game is avoid finding a picture of a train while" 
  Write-Host "scrolling to the very bottom of a Google image search of a four digit number."
  Write-Host "The Train Ducker speeds up the process by loading ten sequential pages at a time."
  Write-Host 'Press "Enter" to start...'
  Write-Host "And good luck ducking those trains!"
  while ([Console]::ReadKey($true).Key.ToString().CompareTo("Enter") -ne0) {}
}
else{
  Write-Host "Welcome back!"
  Write-Host "So you want to start from #$startingNum huh?"
  Write-Host "No problem.  Good luck ducking those trains!"
}

$urlPrefix = 'https://www.google.com/search?tbm=isch&safe=strict&q='
for($i = $startingNum; $i -le 9999; $i += 10){
	for($j = 0; ($number = $i + $j) -le 9999 -and $j -le 9; $j++) {
    $url =  $urlPrefix + $number.ToString()
    start-process $chromeLoc -ArgumentList "--incognito $url"
  }
  # Check if no more numbers
  if ($i -gt 9990){
    Write-Host "You reached the end!"
    Write-Host "Were you able to duck any trains?!?"
    Exit
  }
  # Prompt to continue
  Write-Host 'Press "Enter" to continue or "S" to stop...'
  do{
    $continue = [Console]::ReadKey($true).Key.ToString()
    $nextnum =  ($i + 10).ToString()
    if ($continue.CompareTo("S") -eq 0) {
      $scriptname = $myInvocation.MyCommand.Name
      Write-Host "Your next number is $nextnum."
      Write-Host "Simply run: './$scriptname $nextnum' to continue where you left off."
      Write-Host "Press any key to exit."
      [Console]::ReadKey($true).Key | out-null
      Exit
    }
    if ($continue.CompareTo("Enter") -eq 0) {
      Write-Host "Running next set from $nextnum."
      break
    }
  } while($true)
}
