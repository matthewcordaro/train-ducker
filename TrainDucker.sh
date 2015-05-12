#!/bin/bash

# Train Ducker
# Written by Matthew A. Cordaro

# You may need to change the location of chromium for your computer.
# It is best to use the root path '/a/b/chromium-browser'.
chromeLoc='/usr/bin/chromium-browser'

# Defaults
urlPrefix='https://www.google.com/search?tbm=isch&safe=strict&q='
startingNum=1000
legalNum='^[1-9]{1}[0-9]{3}$'

# Introduction
if [ $# -ne 0 ]
then
  # Returning player
  # Verify arguments
  startingNum=$1
  if ! [[ $startingNum =~ $legalNum ]]; then
    >&2 echo "Error: $startingNum is not a number between 1000 & 9999."
    exit 1
  fi
  echo "Welcome back!"
  echo "So you want to start from $startingNum huh?"
  echo 'No problem.  Press "Enter" to start...'
  echo "And good luck ducking those trains!"
  until
    IFS= read -s -N1 input
    [[ "$input" == $'\x0a' ]]; do :
  done
else
  # New player
  echo "Welcome to the Train Ducker Script!"
  echo "The goal of the Google Images Train Game is avoid finding a picture of a train" 
  echo "while scrolling to the very bottom of a Google image search of a four digit"
  echo "number."
  echo "Train Ducker speeds up the process by loading ten sequential pages at a time."
  echo 'Press "Enter" to start...'
  echo "And good luck ducking those trains!"
  until
    IFS= read -s -N1 input
    [[ "$input" == $'\x0a' ]]; do :
  done
fi

# Generate browser tabs
for((i=startingNum; i<=9999; i+=10)) do
  # Open URLs
  for((currentNum=i; currentNum<=9999 && currentNum<=i+9; currentNum++ )) do
    url=$urlPrefix$currentNum
    #########################################
    $($chromeLoc --incognito "$url" &> /dev/null)
    #########################################
  done
  # Check if no more numbers
  if [ $i -ge 9990 ]; then {
    echo "You reached the end!"
    echo "Were you able to duck any trains?!?"
    exit 0
  } fi
  # Prompt to continue
  echo 'Press "Enter" to continue or "S" to stop...'
  while [ true ]; do
    until
      IFS= read -s -N1 input
      [[ "$input" == $'\x0a' || "$input" = "s" || "$input" = "S" ]]; do :
    done
    nextnum=$((i+10))
    if [[ "$input" = "s" || "$input" = "S" ]]; then
      echo "Your next number is $nextnum."
      echo "Simply run: '$0 $nextnum' to continue where you left off."
      echo "Press any key to exit."
      read -s -n1
      exit 0
    elif [[ "$input" == $'\x0a' ]]; then
      echo "Running next set from $nextnum."
      break
    fi
  done
done
