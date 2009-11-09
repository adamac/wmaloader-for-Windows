# define installer name
outFile "wmaloader installer.exe"
 
# set install directory
InstallDir $PROGRAMFILES\wmaloader
 
# default section start
section
 
# define output path
setOutPath $INSTDIR
 
# specify files to go in output path
CreateDirectory $INSTDIR\image
file /oname=$INSTDIR\image\wma.img image\wma.img
file pthreadGC2.dll
file README
file upnp.dll
file winsw.exe
file winsw.xml
file wmaloader.exe
 
# define uninstaller name
writeUninstaller $INSTDIR\uninstaller.exe

# Add firewall exception
SimpleFC::AddApplication "wmaloader" "$INSTDIR\wmaloader.exe" 0 2 "" 1
Pop $0

ExecWait '"$INSTDIR\winsw.exe" install'
ExecWait '"$INSTDIR\winsw.exe" start'
 
# default section end
sectionEnd
 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
section "Uninstall"

ExecWait '"$INSTDIR\winsw.exe" stop'
ExecWait '"$INSTDIR\winsw.exe" uninstall'

# Remove firewall exception
SimpleFC::RemoveApplication "$INSTDIR\wmaloader.exe"
Pop $0
 
# Always delete uninstaller first
delete $INSTDIR\uninstaller.exe
 
# now delete installed file
delete $INSTDIR\image\wma.img
RMDir /r $INSTDIR\image
delete $INSTDIR\pthreadGC2.dll
delete $INSTDIR\README
delete $INSTDIR\upnp.dll
delete $INSTDIR\winsw.exe
delete $INSTDIR\winsw.xml
delete $INSTDIR\wmaloader.exe
# output files
delete $INSTDIR\winsw.err.log
delete $INSTDIR\winsw.out.log
delete $INSTDIR\winsw.wrapper.log
RMDir $INSTDIR

sectionEnd