FROM jackmckew/pyinstaller-windows

#extra winetrick step to fix "Unimplemented function ucrtbase.dll.crealf called"

RUN apt-get install -y xvfb 
RUN yes Y | xvfb-run winetricks vcrun2019
    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
