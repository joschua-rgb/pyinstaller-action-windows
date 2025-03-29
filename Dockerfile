FROM jackmckew/pyinstaller-windows

#extra winetrick step to fix "Unimplemented function ucrtbase.dll.crealf called"
RUN set -x \
    && sudo apt-get install -y xvfb \
    && Xvfb :0 -screen 0 1024x768x16 & \
    && winetricks allfonts \
    && DISPLAY=:0.0 winetricks vcrun2019 \
    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
