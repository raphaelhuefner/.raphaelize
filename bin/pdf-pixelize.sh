#!/usr/bin/env bash

OUTPUT_RESOLUTION=${OUTPUT_RESOLUTION:-300}

if [ -z "`command -v gs`" ]; then
  echo "Error: Unable to run ''gs''. Exiting."
  echo "On Debian, you can install it like so: sudo apt-get install ghostscript"
  exit 1
fi

# if [ -z "`command -v img2pdf`" ]; then
#   echo "Error: Unable to run ''img2pdf''. Exiting."
#   echo "On Debian, you can install it like so: sudo apt-get install img2pdf"
#   exit 1
# fi

for sourceFileName in "$@"; do
    fileNameStem="${sourceFileName%.pdf}"
    fileNameStem="${fileNameStem%.PDF}"
    destinationFileName="${fileNameStem}.pixelized.pdf"

    gs \
        -r$OUTPUT_RESOLUTION \
        -dTextAlphaBits=4 \
        -dGraphicsAlphaBits=4 \
        -sDEVICE=pdfimage24 \
        -sCompression=JPEG \
        -dJPEGQ=65 \
        -dBATCH \
        -dNOPAUSE \
        -sOutputFile="${destinationFileName}" \
        "${sourceFileName}"

    # tempDir="./${fileNameStem}.pixelizedpages"
    # mkdir "${tempDir}"
    # gs \
    #     -r$OUTPUT_RESOLUTION \
    #     -dTextAlphaBits=4 \
    #     -dGraphicsAlphaBits=4 \
    #     -sDEVICE=jpeg \
    #     -dJPEGQ=65 \
    #     -dBATCH \
    #     -dNOPAUSE \
    #     -sOutputFile="$tempDir/%06d.jpg" \
    #     "$sourceFileName"
    # img2pdf --pillow-limit-break --output "${destinationFileName}" $tempDir/*.jpg
    # rm -rf $tempDir;

    # # tifflzw is grayscale, so it is better for printing
    # gs \
    #     -r$OUTPUT_RESOLUTION \
    #     -dTextAlphaBits=4 \
    #     -dGraphicsAlphaBits=4 \
    #     -sDEVICE=tifflzw \
    #     -dBATCH \
    #     -dNOPAUSE \
    #     -sOutputFile=$tempDir/%06d.tiff \
    #     "$sourceFileName"
    # img2pdf --pillow-limit-break --output ${destinationFileName} $tempDir/*.tiff

done;
exit;

# # ghostscript devices
# # see also https://www.ghostscript.com/doc/current/Devices.htm#File_formats
# alc1900
# alc2000
# alc4000
# alc4100
# alc8500
# alc8600
# alc9100
# ap3250
# appledmp
# atx23
# atx24
# atx38
# bbox
# bit
# bitcmyk
# bitrgb
# bitrgbtags
# bj10e
# bj10v
# bj10vh
# bj200
# bjc600
# bjc800
# bjc880j
# bjccmyk
# bjccolor
# bjcgray
# bjcmono
# bmp16
# bmp16m
# bmp256
# bmp32b
# bmpgray
# bmpmono
# bmpsep1
# bmpsep8
# ccr
# cdeskjet
# cdj1600
# cdj500
# cdj550
# cdj670
# cdj850
# cdj880
# cdj890
# cdj970
# cdjcolor
# cdjmono
# cdnj500
# cfax
# chp2200
# cif
# cljet5
# cljet5c
# cljet5pr
# coslw2p
# coslwxl
# cups
# declj250
# deskjet
# devicen
# dfaxhigh
# dfaxlow
# display
# dj505j
# djet500
# djet500c
# dl2100
# dnj650c
# epl2050
# epl2050p
# epl2120
# epl2500
# epl2750
# epl5800
# epl5900
# epl6100
# epl6200
# eplcolor
# eplmono
# eps2write
# eps9high
# eps9mid
# epson
# epsonc
# escp
# escpage
# faxg3
# faxg32d
# faxg4
# fmlbp
# fmpr
# fpng
# fs600
# gdi
# hl1240
# hl1250
# hl7x0
# hocr
# hpdj1120c
# hpdj310
# hpdj320
# hpdj340
# hpdj400
# hpdj500
# hpdj500c
# hpdj510
# hpdj520
# hpdj540
# hpdj550c
# hpdj560c
# hpdj600
# hpdj660c
# hpdj670c
# hpdj680c
# hpdj690c
# hpdj850c
# hpdj855c
# hpdj870c
# hpdj890c
# hpdjplus
# hpdjportable
# ibmpro
# ijs
# imagen
# inferno
# ink_cov
# inkcov
# itk24i
# itk38
# iwhi
# iwlo
# iwlq
# jetp3852
# jj100
# jpeg
# jpegcmyk
# jpeggray
# la50
# la70
# la75
# la75plus
# laserjet
# lbp310
# lbp320
# lbp8
# lex2050
# lex3200
# lex5700
# lex7000
# lips2p
# lips3
# lips4
# lips4v
# lj250
# lj3100sw
# lj4dith
# lj4dithp
# lj5gray
# lj5mono
# ljet2p
# ljet3
# ljet3d
# ljet4
# ljet4d
# ljet4pjl
# ljetplus
# ln03
# lp1800
# lp1900
# lp2000
# lp2200
# lp2400
# lp2500
# lp2563
# lp3000c
# lp7500
# lp7700
# lp7900
# lp8000
# lp8000c
# lp8100
# lp8200c
# lp8300c
# lp8300f
# lp8400f
# lp8500c
# lp8600
# lp8600f
# lp8700
# lp8800c
# lp8900
# lp9000b
# lp9000c
# lp9100
# lp9200b
# lp9200c
# lp9300
# lp9400
# lp9500c
# lp9600
# lp9600s
# lp9800c
# lps4500
# lps6500
# lq850
# lxm3200
# lxm5700m
# m8510
# md1xMono
# md2k
# md50Eco
# md50Mono
# md5k
# mgr4
# mgr8
# mgrgray2
# mgrgray4
# mgrgray8
# mgrmono
# miff24
# mj500c
# mj6000c
# mj700v2c
# mj8000c
# ml600
# necp6
# npdl
# nullpage
# oce9050
# ocr
# oki182
# oki4w
# okiibm
# oprp
# opvp
# paintjet
# pam
# pamcmyk32
# pamcmyk4
# pbm
# pbmraw
# pcl3
# pclm
# pcx16
# pcx24b
# pcx256
# pcxcmyk
# pcxgray
# pcxmono
# pdfimage24
# pdfimage32
# pdfimage8
# pdfocr24
# pdfocr32
# pdfocr8
# pdfwrite
# pgm
# pgmraw
# pgnm
# pgnmraw
# photoex
# picty180
# pj
# pjetxl
# pjxl
# pjxl300
# pkm
# pkmraw
# pksm
# pksmraw
# plan
# plan9bm
# planc
# plang
# plank
# planm
# plib
# plibc
# plibg
# plibk
# plibm
# png16
# png16m
# png256
# png48
# pngalpha
# pnggray
# pngmono
# pngmonod
# pnm
# pnmraw
# ppm
# ppmraw
# pr1000
# pr1000_4
# pr150
# pr201
# ps2write
# psdcmyk
# psdcmyk16
# psdcmykog
# psdrgb
# psdrgb16
# pwgraster
# pxlcolor
# /pxlmono
# r4081
# rinkj
# rpdl
# samsunggdi
# sj48
# spotcmyk
# st800
# stcolor
# t4693d2
# t4693d4
# t4693d8
# tek4696
# tiff12nc
# tiff24nc
# tiff32nc
# tiff48nc
# tiff64nc
# tiffcrle
# tiffg3
# tiffg32d
# tiffg4
# tiffgray
# tifflzw
# tiffpack
# tiffscaled
# tiffscaled24
# tiffscaled32
# tiffscaled4
# tiffscaled8
# tiffsep
# tiffsep1
# txtwrite
# uniprint
# x11
# x11alpha
# x11cmyk
# x11cmyk2
# x11cmyk4
# x11cmyk8
# x11gray2
# x11gray4
# x11mono
# xcf
# xcfcmyk
# xes
# xpswrite
