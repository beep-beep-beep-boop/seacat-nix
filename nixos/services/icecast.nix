{ config, lib, ... }:
let
    icecastInternalPort = 9002;
    icecastHostname = "iwanttolistentomusic.ilovelain.com";
in
{
    services.icecast = {
        enable = true;
        listen.address = "127.0.0.1";
        listen.port = icecastInternalPort;
        hostname = icecastHostname;
        admin.user = "";
        admin.password = "";
    };

    services.caddy.virtualHosts."${icecastHostname}".extraConfig = ''
        reverse_proxy 127.0.0.1:${toString icecastInternalPort} {
            flush_interval -1
        }

        # Block access to the admin interface
        route /admin* {
            respond "Admin interface is disabled" 403
        }
    '';
}