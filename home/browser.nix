{ pkgs, ... }: {
  home.packages = with pkgs; [
    (brave.override {
      enableVulkan = true;
      commandLineArgs = "--enable-features=VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo --ignore-gpu-blocklist --enable-zero-copy";
    })
  ];
}
