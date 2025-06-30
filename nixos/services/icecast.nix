{ config, lib, ... }:
let
    icecastInternalPort = 9002;
in
{
    services.icecast = {
        enable = true;
        listen.address = "127.0.0.1";
        listen.port = icecastInternalPort;
    };

    services.caddy.virtualHosts."iwanttolistentomusic.ilovelain.com".extraConfig = ''
        reverse_proxy 127.0.0.1:${icecastInternalPort} {
            flush_interval -1
        }

        # Block access to the admin interface
        route /admin* {
            respond "Admin interface is disabled" 403
        }

        encode * none
    '';
}