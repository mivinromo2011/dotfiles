#! /bin/sh

WIDTH=${WIDTH:-200}
HEIGHT=${HEIGHT:-200}
DATEFMT=${DATEFMT:-"+%a %d.%m.%Y %H:%M:%S"}
SHORTFMT=${SHORTFMT:-"+%H:%M:%S"}

OPTIND=1
while getopts ":f:W:H:" opt; do
    case $opt in
        f) DATEFMT="$OPTARG" ;;
        W) WIDTH="$OPTARG" ;;
        H) HEIGHT="$OPTARG" ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done


echo "$LABEL$(date "$DATEFMT")"
echo "$LABEL$(date "$SHORTFMT")"