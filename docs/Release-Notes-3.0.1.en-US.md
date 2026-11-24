# NexForge · 连接锻造 3.0.1

NexForge is a local-first AI game development workstation. It brings game design, asset management, animation, materials, Blender, and Unreal Engine workflows into a traceable visual-canvas system.

## Design idea

NexForge does not treat AI as an unrestricted generator. Human design, real assets, visual relationships, and professional-tool bridges form a reusable production flow. The user expresses missions, characters, factions, maps, dialogue, items, and production relationships on canvases. The Agent then reads an explicit scope, proposes a plan, calls Blender/UE tools, and returns logs and diffs.

## Recent updates

- Design overview: missions, scene dialogue, characters, factions, relations, maps, locations/vehicles/collectibles, crafting, concepts, documents, calendar, parts, motion, materials, UE behavior, bugs, and development logs.
- Relations: structured fields for characters, factions, locations, and relationship changes. Characters support name, protagonist/supporting/NPC type, faction, motivation, and asset references. Factions support name, emblem, motto, core attributes, allies, and enemies.
- Scene dialogue: scene, speaker, emotion, line, camera, trigger, and event result.
- Canvas: infinite canvas, zoom, pan, grid, contextual node templates, wires, marquee/multi-select, copy, delete, undo/redo, and board/list views.
- Asset library: folder scanning, thumbnails, source paths, drag-to-node references, and project references.
- Motion template library: FBX, BVH, GLB, and glTF import, thumbnails, clips, and skeleton checks.
- AI assistant: API models, local Ollama/LM Studio, capability probes, and per-module routing.
- Professional bridges: Blender Bridge and UE5.9 AIGW Bridge. Real writes require a ready bridge, an explicit scope, and human confirmation.
- Design packs: `.aigw-design.json` structured import/export for modules, nodes, edges, asset references, and revisions.

## Testing and boundaries

UE5.9 and Blender bridge connectivity has been verified with a real gun disassembly/assembly proof. When no AI provider is configured, NexForge never pretends that an Agent ran. UE asset and level persistence follows editor safety rules and requires Save All/Save As inside UE.

## Installation

Run `安装NexForge.cmd`. The app is installed to `%LOCALAPPDATA%\\NexForge` and a desktop shortcut is created. Run `卸载NexForge.cmd` to remove it.
