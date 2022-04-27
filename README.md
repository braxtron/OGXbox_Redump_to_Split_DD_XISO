This script batch converts Xbox Redumps (complete disc rips from archive.org) to playable xisos by using DD to get rid of the video partition and then fsplit to split the resulting iso. Titles are truncated so that the final isos are 42 characters max, so that they can be used on an Xbox. These isos will need to be further processed by the script built into XBMC4Gamers in order to create an attach.xbe and make them playable.

You will have the option to save the source isos or have them deleted.

Place all full redump isos in the 'Games' directory and run the powershell script by double clicking DD_Create_and_Split.bat or running the following command:

You'll need dd.exe aliased on your machine. I'm not sure if the included dd.exe will be corrrectly called from the script.

powershell -ExecutionPolicy ByPass -File .\DD_Create_and_Split.ps1

This has no error handling and has only been tested on Windows 10. I can not vouch in any way for the provenance of fSplit.exe, fSplit.exe.config, xdvdfs_maker.exe, or dd.exe. This script comes with no guarantees or warranties. You can find me at:

twitter: braxtron

instagram: son_of_mr_snails
