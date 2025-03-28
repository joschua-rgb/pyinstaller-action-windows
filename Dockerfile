FROM jackmckew/pyinstaller-windows

#extra winetrick step to fix "Unimplemented function ucrtbase.dll.crealf called"
RUN set -x \
    && rm -f "$W_TMP"/* \
    && wget -P "$W_TMP" https://download.visualstudio.microsoft.com/download/pr/5efdbcb7-d3bd-4432-a2fb-b267c386e2f3/49545CB0F6499C4A65E1E8D5033441EEEB4EDFAE465A68489A70832C6A4F6399/VC_redist.x86.exe \
    && cabextract -q --directory="$W_TMP" "$W_TMP"/VC_redist.x86.exe \
    && cabextract -q --directory="$W_TMP" "$W_TMP/a10" \
    && cabextract -q --directory="$W_TMP" "$W_TMP/a11" \
    && cd "$W_TMP" \
    && rename 's/_/\-/g' *.dll \
    && cp "$W_TMP"/*.dll "$W_SYSTEM64_DLLS"/

    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
