{ config, lib, ... }:
{
    services.thelounge = {
        enable = true;
        public = false;
        port = 9000;
        extraConfig = {
            reverseProxy = true;
            host = "127.0.0.1";
            defaults = {
                name = "Your Network";
                host = "localhost";
                port = 6697;
            };
        };
    };

    services.caddy.virtualHosts."irc.me0w.meowmeow.foo".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString config.services.thelounge.settings.port}
    '';
}