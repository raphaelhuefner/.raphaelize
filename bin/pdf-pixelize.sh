#! /bin/sh

outputResolution=600

for sourceFileName in "$@"; do
    destinationFileName=${sourceFileName%.pdf};
    destinationFileName=${destinationFileName%.PDF};
    destinationFileName=$destinationFileName.pixelized.pdf;

    tempDir=`mktemp -d -t`;
    gs -r$outputResolution -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=tifflzw -dBATCH -dNOPAUSE -sOutputFile=$tempDir/%06d.tiff "$sourceFileName";
    for tiffPageFileName in $tempDir/*.tiff ; do
        a2ping --papersize=a4 $tiffPageFileName pdf: $tiffPageFileName.pdf
    done;
    pdfjoin --paper a4paper --orient portrait --outfile "$destinationFileName" $tempDir/*.tiff.pdf
    rm -rf $tempDir;
done;
exit;










