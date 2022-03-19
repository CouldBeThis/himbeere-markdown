#!/bin/bash

clear

function Confirm {
	read -p "$B All good? Enter to continue, ctrl-c to cancel$BO"
}

###	Text styles
	## Bold
	B=$(tput smso)
	BO=$(tput rmso)

##	Underline	
	U=$(tput smul)
	UO=$(tput rmul)

	## set foreground color SHORT VARIABLE NAMES 
	Ba=$(tput setaf 0)
	R=$(tput setaf 1)
	G=$(tput setaf 2)
	Y=$(tput setaf 3)
	Bu=$(tput setaf 4)
	M=$(tput setaf 5)
	C=$(tput setaf 6)
	W=$(tput setaf 7)
	Off=$(tput sgr0)	## reset all attributes

### Date stamp
	DateTimeStamp=$(date +"%y%m%d-%H%M%S")
	echo "▶ DateTimeStamp is	$DateTimeStamp"
###	New filename for copied original files
	BackupFileName=$DateTimeStamp-bkup
	echo "▶ BackupFileName is	$BackupFileName"
###	Metadata 
	ThisScript=$(basename "$0")
	echo "▶ ThisScript is		$ThisScript"
### The URL of the repo
	RepoURL="https://github.com/CouldBeThis/himbeere-markdown"
	echo "▶ RepoURL is		$RepoURL"
###	Starting directory
	RepoDir=$(pwd)
	echo "▶ RepoDir is		$RepoDir"
###	Target directory
	GeanyConfigDir=~/.config/geany
	echo "▶ GeanyConfigDir is	$GeanyConfigDir"

### File path for Markdown filetype definition
	FileTypeMarkdown=filedefs/filetypes.markdown
	echo "▶ FileTypeMarkdown is	$FileTypeMarkdown"

### File path for YAML file type definition
	FileTypeYaml=filedefs/filetypes.yaml
	echo "▶ FileTypeYaml is	$FileTypeYaml"

### File path for color scheme
	ColorSchemes=colorschemes/himbeere-markdown.conf
	echo "▶ ColorSchemes is	$ColorSchemes"

#Confirm
tabs -4
echo "$Bu
Will rename any of the following files that already exist so you can revert if desired:$Off"

echo "In directory $U$GeanyConfigDir$UO:"

echo "	↳ $M/$FileTypeMarkdown$Off 
		to ⇢ $C/$FileTypeMarkdown$Bu-$BackupFileName$Off"

echo "	↳ $M/$FileTypeYaml$Off 
		to ⇢ $C/$FileTypeYaml$Bu-$BackupFileName$Off"

echo "	↳ $M/$ColorSchemes$Off 
		to ⇢ $C/$ColorSchemes$Bu-$BackupFileName$Off"

Confirm


mv -n $GeanyConfigDir/$FileTypeMarkdown $GeanyConfigDir/$FileTypeMarkdown-$BackupFileName
mv -n $GeanyConfigDir/$FileTypeYaml $GeanyConfigDir/$FileTypeYaml-$BackupFileName
mv -n $GeanyConfigDir/$ColorSchemes $GeanyConfigDir/$ColorSchemes-$BackupFileName

echo -e "$Bu\e IIf you don't happen to have any of the above files, it will have made an error. No problem.$Off"

echo "$Bu
Now I will COPY the following files from repo to your Geany config directory:$Off"

echo "From directory $U$RepoDir$UO:"

echo "	↳ $M/$FileTypeMarkdown$Off 
		to ⇢ $C$GeanyConfigDir/$Bu$FileTypeMarkdown$Off"

echo "	↳ $M/$FileTypeYaml$Off 
		to ⇢ $C$GeanyConfigDir/$Bu$FileTypeYaml$Off"

echo "	↳ $M/$ColorSchemes$Off 
		to ⇢ $C$GeanyConfigDir/$Bu$ColorSchemes$Off"

echo "$B If you would like to LINK the files instead, stop the script now and edit the script (instructions in comments below this text)$Off"
Confirm

## Default is to COPY the files from the repo to config directory.  
## If you wish to LINK files instead, uncomment the following lines and re run the script:
#Confirm
#ln -s $RepoDir/$FileTypeMarkdown $GeanyConfigDir/$FileTypeMarkdown
#ln -s $RepoDir/$FileTypeYaml $GeanyConfigDir/$FileTypeYaml
#ln -s $RepoDir/$ColorSchemes $GeanyConfigDir/$ColorSchemes

cp -n $RepoDir/$FileTypeMarkdown $GeanyConfigDir/$FileTypeMarkdown
cp -n $RepoDir/$FileTypeYaml $GeanyConfigDir/$FileTypeYaml
cp -n $RepoDir/$ColorSchemes $GeanyConfigDir/$ColorSchemes

echo -e "$Bu\e TThe following text will be appended to all the relevant files If you don't like this, ctrl-C to stop. $Off"

function CommentText {
	echo "
	
	## ===================================================== ##
	##	This file has been customized. 
	##	See README.md in repo for information.
	##	▶ Repo:	$RepoURL 
	##	▶ Local repo location: $RepoDir 
	##	▶ Files included: 
	##		● $GeanyConfigDir/$FileTypeMarkdown
	##		● $GeanyConfigDir/$FileTypeYaml
	##		● $GeanyConfigDir/$ColorSchemes
	##	▶ Backups were created:
	##		● $GeanyConfigDir/$FileTypeMarkdown-$BackupFileName
	##		● $GeanyConfigDir/$FileTypeYaml-$BackupFileName
	##		● $GeanyConfigDir/$ColorSchemes-$BackupFileName
	## ===================================================== ##" 
}

CommentText

Confirm

CommentText >> $GeanyConfigDir/$FileTypeMarkdown
CommentText >> $GeanyConfigDir/$FileTypeYaml
CommentText >> $GeanyConfigDir/$ColorSchemes

echo "$B Almost Done here! Next you need to:$Off"
	echo " ▶ If Geany is open, select Tools > Reload Configuration"
	echo " ▶ In Geany, select View > Change Color Scheme"

echo "$B Do you want to get rid of the backup files? $Off
Will use trash-cli first then give option for rm after in case you don't have that.'
Files to be deleted:
	✘ $C$GeanyConfigDir/$FileTypeMarkdown$Bu-$BackupFileName$Off
	✘ $C$GeanyConfigDir/$FileTypeYaml$Bu-$BackupFileName$Off
	✘ $C$GeanyConfigDir/$ColorSchemes$Bu-$BackupFileName$Off"
Confirm

trash $GeanyConfigDir/$FileTypeMarkdown-$BackupFileName
trash $GeanyConfigDir/$FileTypeYaml-$BackupFileName
trash $GeanyConfigDir/$ColorSchemes-$BackupFileName
Confirm
rm $GeanyConfigDir/$FileTypeMarkdown-$BackupFileName
rm $GeanyConfigDir/$FileTypeYaml-$BackupFileName
rm $GeanyConfigDir/$ColorSchemes-$BackupFileName

echo "╳╳╳╳╳╳╳╳╳╳ done ╳╳╳╳╳╳╳╳╳╳"


##reset tabs to default
tabs -8

















