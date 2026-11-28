# NexForge · 连接锻造 3.0.1 — 2026-11-28 Update

This update publishes a Windows x64 installer supplied separately by the maintainer. The product version remains 3.0.1.

## Download and verify

- Installer: [NexForge-Setup-3.0.1-build-2026-11-28.exe](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-Setup-3.0.1-build-2026-11-28.exe) (81,322,488 bytes)
- SHA-256: `4F89C8C3549DA30766C529BA749660C6E1163D1084255DFB51C0BBE9BFB9B3A3`
- Checksum file: [SHA256-3.0.1-build-2026-11-28.txt](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/SHA256-3.0.1-build-2026-11-28.txt)

The installer contains a publisher self-signed certificate; Authenticode chain verification on the publishing host did not trust it. SHA-256 confirms that a download matches this published file; it does not certify the publisher or the program's safety. This installer was not rebuilt or independently clean-installed during this publishing operation. The November 25 installation test report applies only to the earlier installer.

## Highlights

- Improved native UE asset type recognition, distinguishing motion assets from skeletons and animation Blueprints.
- Added native motion-template indexing, hover playback, scrolling, and large-library improvements.
- Simplified Blender / UE bridge installation and target selection.
- Fixed motion classification, preview playback, rescanning, multi-window sessions, and connection-bar issues.

The final development regression record reports 60 application tests and 12 Python bridge tests passed; real connection and scene-read checks used UE 5.9 and Blender 4.2.2. These are not clean-machine installation tests of this installer. First-time UE motion previews require the owning project, bridge, preview skeletal mesh, and local Blender; not every asset has a preview.

## Guides, source, and license

- [Feature update (bilingual)](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-3.0.1-Feature-Update-Bilingual.md)
- [Code changes and bug fixes (bilingual)](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-3.0.1-Code-Changes-and-Bug-Fixes-Bilingual.md)
- [Upgrade and usage guide (bilingual)](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-3.0.1-Upgrade-and-Usage-Guide-Bilingual.md)

The public source ZIP is an earlier snapshot and does not include all code changes described for 2026-11-28; it is not represented as matching source for this installer. The application is marked `UNLICENSED`; public availability does not grant permission to freely copy, modify, or redistribute it.
