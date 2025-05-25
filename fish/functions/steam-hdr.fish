function steam-hdr --wraps='MANGOHUD=0 gamemoderun gamescope --mangoapp --hdr-enabled -w 2560 -h 1440 -r 360 -f -- env DXVK_HDR=1 steam' --description 'alias steam-hdr=MANGOHUD=0 gamemoderun gamescope --mangoapp --hdr-enabled -w 2560 -h 1440 -r 360 -f -- env DXVK_HDR=1 steam'
  MANGOHUD=0 gamemoderun gamescope --mangoapp --hdr-enabled -w 2560 -h 1440 -r 360 -f -- env DXVK_HDR=1 steam $argv
        
end
