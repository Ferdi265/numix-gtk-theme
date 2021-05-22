#!/bin/bash

detect_inkscape_version() {
    echo "render-assets: checking inkscape version"
    INKSCAPE_VERSION="$(inkscape --version 2>/dev/null | head -n1 | cut -d\  -f2)"
    INKSCAPE_VERSION_MAJOR="$(cut -d. -f1 <<< "$INKSCAPE_VERSION")"
    INKSCAPE_VERSION_MINOR="$(cut -d. -f2 <<< "$INKSCAPE_VERSION")"
    INKSCAPE_VERSION_PATCH="$(cut -d. -f3 <<< "$INKSCAPE_VERSION")"

    if [[ "$INKSCAPE_VERSION_MAJOR" -gt 1 ]]; then
        echo "render-assets: detected unsupported inkscape version ($INKSCAPE_VERSION)"
        echo "render-assets: attempting to use flags for 1.x"
        INKSCAPE_FLAVOUR=1.x
    elif [[ "$INKSCAPE_VERSION_MAJOR" -eq 1 ]]; then
        echo "render-assets: detected inkscape version 1.x ($INKSCAPE_VERSION)"
        INKSCAPE_FLAVOUR=1.x
    elif [[ "$INKSCAPE_VERSION_MAJOR" -eq 0 && "$INKSCAPE_VERSION_MINOR" -gt 90 ]]; then
        echo "render-assets: detected inkscape version 0.9x ($INKSCAPE_VERSION)"
        INKSCAPE_FLAVOUR=0.9x
    else
        echo "render-assets: detected unsupported inkscape version ($INKSCAPE_VERSION)"
        echo "render-assets: attempting to use flags for 0.9x"
        INKSCAPE_FLAVOUR=0.9x
    fi
}

inkscape_render() {
    FILE="$1"
    shift

    case "$INKSCAPE_FLAVOUR" in
        1.x) inkscape --export-type=png --export-filename="$FILE" "$@";;
        0.9x) inkscape --export-png="$FILE" "$@";;
        *) echo "render-assets: unknown inkscape flavour '$INKSCAPE_FLAVOUR'";;
    esac
}

print_header() {
    printf "render-assets: $THEMENAME [% 3d / % 3d ]:" "$CUR" "$TOTAL"
}

if [[ $# -eq 1 ]]; then
    THEMENAME="$1"
    HEADER="render-assets: $THEMENAME"
else
    echo "render-assets: invalid arguments"
    echo "usage: render-assets.sh [THEMENAME]"
    exit 1
fi

if [[ "$ASSETS_QUIET" -eq 1 ]]; then
    INKSCAPE_ERR_TMP="$(mktemp --suffix=.inkscape.log)"
    INKSCAPE_REDIR="$INKSCAPE_ERR_TMP"
else
    INKSCAPE_REDIR="/dev/stderr"
fi

SRC_FILE="src/assets/all-assets.svg"
ASSETS_DIR="src/assets"
INDEX="src/assets/all-assets.txt"

detect_inkscape_version

TOTAL=$((2 * $(wc -l < "$INDEX")))
CUR=1
for f in $(cat "$INDEX"); do
    echo "$(print_header) rendering $ASSETS_DIR/$f.png"; CUR=$((CUR + 1))
    inkscape_render "$ASSETS_DIR/$f.png" \
              --export-id=$f \
              --export-id-only \
              $SRC_FILE >/dev/null 2>"$INKSCAPE_REDIR"
    [[ $? -ne 0 && -n "$INKSCAPE_ERR_TMP" ]] && sed 's/^/error: /' "$INKSCAPE_ERR_TMP"

    echo "$(print_header) rendering $ASSETS_DIR/$f@2.png"; CUR=$((CUR + 1))
    inkscape_render "$ASSETS_DIR/$f@2.png" \
              --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              $SRC_FILE >/dev/null 2>"$INKSCAPE_REDIR"
    [[ $? -ne 0 && -n "$INKSCAPE_ERR_TMP" ]] && sed 's/^/error: /' "$INKSCAPE_ERR_TMP"
done

[[ -n "$INKSCAPE_ERR_TMP" ]] && rm -f "$INKSCAPE_ERR_TMP"

exit 0
