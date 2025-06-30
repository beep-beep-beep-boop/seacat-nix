{ config, lib, ... }:
{
    services.tailscale.enable = true;
    
    # make the tailscale command available
    environment.systemPackages = [ pkgs.tailscale ];

    networking.firewall = {
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
    };
}