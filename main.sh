#!/bin/bash
set -e

while getopts df: OPTION "$@"; do
    case $OPTION in
    d)
        set -x
        ;;
    f)
        XCFFILE=${OPTARG}
        ;;
    esac
done

if [[ -z "$XCFFILE" ]]; then
    echo "usage: `basename $0` [-d] -f <xcfFile>"
    exit 1
fi

# Start gimp with python-fu batch-interpreter
gimp -i --batch-interpreter=python-fu-eval -b - << EOF
import gimpfu

TITLE = ""
SUBTITLE = ""

def convert(filename):
    img = pdb.gimp_file_load(filename, filename)
    new_name = filename.rsplit(".",1)[0] + ".png"

	layers = gimp.image_list()[0].layers
	pdb.gimp_text_layer_set_text(layers[0], TITLE)
	pdb.gimp_text_layer_set_text(layers[1], SUBTITLE)

    layer = pdb.gimp_image_merge_visible_layers(img, 1)

    pdb.gimp_file_save(img, layer, new_name, new_name)
    pdb.gimp_image_delete(img)

convert('${XCFFILE}')

pdb.gimp_quit(1)
EOF
