# Train Ducker Scripts
The Train Ducker Scripts speed up the process of playing the Google Images Train Game by loading ten pages at a time in sequential order. You can specify a point to continue (or start) from by appending the number as an argument.

# The Google Images Train Game Rules
- Go to [Google Image Search](https://www.google.com/search?tbm=isch&safe=strict "Open in incognito mode!") and enter a 4 digit number.
- If you come a cross ANY type of train (even models, artwork, etc.) you loose.
- You must be in incognito mode & safe search must be on.

_Can you duck all the trains_?

# Getting Started
## Windows
1. You'll need to read up on execution policys... [Google it](https://www.google.com/search?q=set-executionpolicy "set-executionpolicy"). I recommend _RemoteSigned_.
1. The location of `chrome.exe` is set to the default installation location of _C:\Program Files (x86)\Google\Chrome\Application\chrome.exe_. Edit the `$chromeLoc` variable if necessary. It's close to the top of the file.
1. Go to the root directory and run the [Train Ducker PowerShell Script](https://github.com/matthewcordaro/train-ducker-scripts/blob/master/TrainDucker.ps1 "Train Ducker"):
```
    ./TrainDucker.ps1
```
1. Follow the instructions there.
    
## Linux
I'll get around to porting the code at some point.

## OSX
I have no plans to port.  If someone wishes to port it, that would be awesome. Once the Linux version is done it shouldn't be very different.

### NonChromium based browsers
Once again, I have no plans to port & if someone wishes to do it, it would be awesome.