{ pkgs }: {
    deps = [
      pkgs.unzip
      pkgs.python313Packages.pyngrok
        pkgs.openjdk17
        # any other deps
    ];
}
