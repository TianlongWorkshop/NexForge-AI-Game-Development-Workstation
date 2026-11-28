# NexForge · 连接锻造 3.0.1

NexForge is a local-first AI game development workstation that brings game design, asset management, motion templates, Blender, and Unreal Engine workflows into a traceable workspace. **Human-led, AI-assisted:** users choose inputs and approve changes; the workstation helps organize assets, preview motion, and connect professional tools.

**Product overview:** [NexForge main page](https://tianlongworkshop.github.io/NexForge-AI-Game-Development-Workstation/about/) · **Download:** [Windows installer](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-Setup-3.0.1-build-2026-11-28.exe) · [SHA-256 checksum](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/SHA256-3.0.1-build-2026-11-28.txt) · [All v3.0.1 release files](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/tag/v3.0.1)

## What’s new

- **Asset recognition:** UE assets prefer serialized type metadata over filename-only guesses. Images, audio/video, models, Blender files, UE projects, and native assets are categorized separately. Recognition and visual preview have separate statuses.
- **Native motion templates:** Index animation sequences, montages, composites, blend spaces, aim offsets, and pose assets from animation files, UE projects, and package folders. Skeletons and animation Blueprints are distinguished from playable clips. Twelve KayKit starter motions retain their source and CC0-1.0 information; retargeting may be needed for other characters.
- **Animated previews:** Motion cards play on hover and stop when the pointer leaves. UE motion assets can reuse preview caches. Visible-range rendering and scrolling improve large template libraries.
- **Editor setup:** “Install and connect” detects running editors and projects, with user selection when multiple targets exist. Blender uses version-appropriate plugin locations and a managed startup loader. The UE bridge installs into the selected project. First-time setup may require reopening the editor.
- **Reviewable AI workflow:** An editor connection does not configure an AI provider. Configure an API or Ollama/LM Studio separately; confirm the target and scope before writing to a real project.

## Fixes and verification

Fixes address UE animations misclassified as materials, native motion unavailable while UE is closed, static motion cards, missing scrolling, large-list slowdowns, duplicate connection bars after search, playback interrupted by rescans, cumbersome plugin setup, and multi-window session mix-ups. See [Code changes and bug fixes](docs/02-代码变更与Bug修复-中英双语.md).

The final development regression run passed **60 application tests and 12 Python bridge tests**. Real-editor checks covered UE 5.9 and Blender 4.2.2 connections and scene reads. The Game Animation Sample index produced 2,288 motion/pose entries; this is an index count, not a claim that every entry has an animated preview. First-time UE preview generation requires the owning project, bridge, preview skeletal mesh, and local Blender.

This is not a complete game or universal renderer. Unsupported UE packages, cooked/encrypted assets, missing dependencies, and untested editor versions can affect recognition and previews. A fully automated Blueprint execution engine is outside this update.

## Upgrade and use

1. Download the installer supplied with the [v3.0.1 Release](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/tag/v3.0.1), exit NexForge, and run it.
2. Preserve `%LOCALAPPDATA%/NexForge/Data`; do not delete or overwrite personal data when updating application files.
3. Check Blender/UE connections in Settings. If first-time plugin setup asks for a restart, save your scene/project and reopen the same editor.
4. Configure an API or Ollama/LM Studio in Settings as needed. Editor bridges can work independently, but AI tasks need an available model.
5. Add files/folders in the asset library; import animation files, UE projects, or package folders in the motion library. Allow time for initial indexing and preview generation.

See the full [Upgrade and usage guide](docs/03-升级与使用指南-中英双语.md). The newly supplied installer still identifies as **3.0.1**; its SHA-256 is in the Release. It was not independently clean-installed during this publishing operation.

## Get involved

Developers are welcome to review the code, report reproducible issues, and suggest improvements. Include application/editor versions and reproduction steps; remove secrets and private assets before sharing. Full bilingual guides and change details are in `docs/`.

**Important:** The current `NexForge-3.0.1-Source.zip` is an earlier source snapshot and does not contain all code changes described for 2026-11-28. No matching updated source archive was supplied with this installer, so the older archive is not presented as matching source. The application package remains `UNLICENSED`; public availability does not grant permission to freely copy, modify, or redistribute it. KayKit's CC0 notice applies only to those motion assets.
