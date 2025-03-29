FROM jackmckew/pyinstaller-windows

ENV W_DRIVE_C=/wine/drive_c
ENV W_WINDIR_UNIX="$W_DRIVE_C/windows"
ENV W_SYSTEM64_DLLS="$W_WINDIR_UNIX/system32"
ENV W_TMP="$W_DRIVE_C/windows/temp"

#extra winetrick step to fix "Unimplemented function ucrtbase.dll.crealf called"
RUN set -x \
    && sudo apt-get install -y xvfb \
    && Xvfb :0 -screen 0 1024x768x16 & \
    && winetricks allfonts \
    && DISPLAY=:0.0 winetricks vcrun2019 \
    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
