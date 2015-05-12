# PowerShell

# Train Ducker
# Written by Matthew A. Cordaro

# You may need to change the location of chrome for your computer.
# It is best to use the root path 'X:\a\b\chrome.exe'.
$chromeLoc = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'

# Defaults
$urlPrefix = 'https://www.google.com/search?tbm=isch&safe=strict&q='
$startingNum = 1000
$legalNum = '^[1-9]{1}[0-9]{3}$'

# Introduction
if ($args[0]){
  # Returning player
  # Verify arguments
  $startingNum = $args[0]
  if ($startingNum -notmatch $legalNum){
    echo "Error: $startingNum is not a number between 1000 & 9999." 
    exit 1
  }
  echo "Welcome back!"
  echo "So you want to start from $startingNum huh?"
  echo 'No problem.  Press "Enter" to start...'
  echo "And good luck ducking those trains!"
  while ([Console]::ReadKey($true).Key.ToString().CompareTo("Enter") -ne0) {}
} else {
  # New player
  echo "Welcome to the Train Ducker Script!"
  echo "The goal of the Google Images Train Game is avoid finding a picture of a train" 
  echo "while scrolling to the very bottom of a Google image search of a four digit"
  echo "number."
  echo "Train Ducker speeds up the process by loading ten sequential pages at a time."
  echo 'Press "Enter" to start...'
  echo "And good luck ducking those trains!"
  while ([Console]::ReadKey($true).Key.ToString().CompareTo("Enter") -ne0) {}
}

# Generate browser tabs
for($i = $startingNum; $i -le 9999; $i += 10){
  # Open URLs
  for($currentNum = $i; $currentNum -le 9999 -and $currentNum -le $i+9; $currentNum++) {
    $url =  $urlPrefix + $currentNum.ToString()
    start-process $chromeLoc -ArgumentList "--incognito $url"
  }
  # Check if no more numbers
  if ($i -ge 9999){
    echo "You reached the end!"
    echo "Were you able to duck any trains?!?"
    exit 0
  }
  # Prompt to continue
  echo 'Press "Enter" to continue or "S" to stop...'
  while($true){
    $continue = [Console]::ReadKey($true).Key.ToString()
    $nextnum =  ($i + 10).ToString()
    if ($continue.CompareTo("S") -eq 0) {
      $scriptname = $myInvocation.MyCommand.Name
      echo "Your next number is $nextnum."
      echo "Simply run: './$scriptname $nextnum' to continue where you left off."
      echo "Press any key to exit."
      [Console]::ReadKey($true).Key | out-null
      exit 0
    }
    if ($continue.CompareTo("Enter") -eq 0) {
      echo "Running next set from $nextnum."
      break
    }
  } 
}
