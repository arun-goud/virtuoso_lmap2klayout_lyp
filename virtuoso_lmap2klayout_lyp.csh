#!/usr/bin/csh

if ( $#argv != 1) then
  echo "Usage:\n\t $0 <virtuoso map file>"
  exit
endif

set virtuoso_lmap=$1
set klayout_lyp="klayout.lyp"
echo "Converting $virtuoso_lmap --> klayout.lyp"
awk 'BEGIN{printf "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<layer-properties>\n"}{if($0!~/^#/ && $0!~/^\s*$/){printf " <properties>\n  <name/>\n  <source>'"'"'%s:%s'"'"' %s/%s@1</source>\n </properties>\n",$1,$2,$3,$4}}END{printf "</layer-properties>\n"}' $virtuoso_lmap > $klayout_lyp

if ( -f "$klayout_lyp" ) then
	echo "Done."
	echo "To use klayout.lyp: KLayout -> File menu -> Load Layer Properties -> $klayout_lyp"
else
	echo "There was an error generating $klayout_lyp"
endif


