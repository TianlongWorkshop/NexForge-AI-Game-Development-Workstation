# NexForge · 连接锻造 3.0.1

NexForge is a local-first AI game development workstation that brings game design, asset management, motion templates, Blender, and Unreal Engine workflows into a traceable workspace. **Human-led, AI-assisted:** users choose the inputs and approve changes; the workstation helps organize, preview, and connect professional tools.

**Product overview:** [中文 / English](https://tianlongworkshop.github.io/NexForge-AI-Game-Development-Workstation/about/) · **Download:** [Windows installer](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/NexForge-Setup-3.0.1-build-2026-11-28.exe) · [SHA-256 checksum](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/download/v3.0.1/SHA256-3.0.1-build-2026-11-28.txt) · [All v3.0.1 release files](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/tag/v3.0.1)

## 中文

### 3.0.1 本轮功能更新

- **更准确的资产识别：** UE 资源优先读取包内类型注册信息，降低仅按文件名分类造成的误判；图片、音视频、模型、Blender 工程、UE 工程及原生资产按类型呈现。封面优先使用内嵌图像或同目录同名图片；识别结果与内容预览状态分别显示。
- **原生动作模板：** 可从动画文件、UE 工程和资源包文件夹索引动画序列、蒙太奇、复合动画、混合空间、瞄准偏移和姿态资产；骨架及动画蓝图等与可播放动作区分。提供 12 个带来源和 CC0-1.0 信息的 KayKit 基础动作模板；跨角色使用可能需要重定向。
- **动态预览与大列表体验：** 动作卡片支持悬停播放、移开停止；UE 动作资产可复用预览缓存。模板列表使用可见范围绘制并支持滚动，改善大型模板库体验。
- **Blender / UE 安装连接：** 设置中可使用“安装并连接”识别已打开的编辑器和工程；多个目标时由用户选择。Blender 按版本使用对应插件目录及启动加载器；UE 插件安装到所选工程，并在需要时提示保存、重开。首次安装通常需要重启对应编辑器。
- **更可审查的制作流程：** AI 助手仍需用户配置 API 或本地模型。编辑器连接并不代表 AI 模型已经配置；对真实工程写入前应确认目标和范围。

### 修复、验证与适用范围

修复了 UE 动画被误分类为材质、关闭 UE 后无法索引原生动画、动作卡片不播放、动作页面无法滚动、大型模板列表卡顿、搜索重复显示连接栏、重新扫描打断播放、插件手动安装/启用繁琐，以及多窗口连接到错误会话等问题。实现位置和主要接口见[代码变更与 Bug 修复](docs/02-代码变更与Bug修复-中英双语.md)。

开发阶段最后一轮回归为 **60 项应用测试 + 12 项 Python 桥接测试，均通过**。实机验证包含 UE 5.9 与 Blender 4.2.2 的连接和场景读取。Game Animation Sample 索引到 2,288 项动作/姿态条目；这是索引数，不代表每项都已有动态预览。首次生成 UE 动作预览需要所属工程、桥接、预览骨架网格和本机 Blender。

本版本不是完整游戏或通用渲染器；不支持的 UE 包、加密/烘焙资源、缺失依赖及未实测的编辑器版本可能影响识别和预览。蓝图全自动执行也不在本轮交付范围内。自动化测试通过不等于每种机器和工程均已完成端到端验收。

### 升级与使用

1. 从 [v3.0.1 Release](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/tag/v3.0.1) 下载本次提供的安装程序，退出 NexForge 后运行安装包。
2. 保留用户数据目录 `%LOCALAPPDATA%/NexForge/Data`；升级程序时不要删除或覆盖个人数据。
3. 启动后在“设置”里检查 Blender/UE 连接。若首次安装插件提示重开，先保存场景或工程，再重新打开原来的编辑器窗口。
4. 按需在设置中配置 API 或 Ollama/LM Studio；没有可用模型时，编辑器桥接仍可单独使用，但 AI 助手不能执行模型任务。
5. 在资产库添加文件/文件夹；在动作库导入动画文件、UE 工程或资源包。等待首次索引和预览缓存生成。

完整的升级、连接、资产导入、动作预览、删除安全及故障排查步骤见[升级与使用指南](docs/03-升级与使用指南-中英双语.md)。本次附带的新安装包版本仍标为 **3.0.1**；其 SHA-256 在 Release 附件中。该更新包在本次发布操作中未单独重新进行干净机器安装测试，请结合随附历史测试报告和此处适用范围说明判断。

### 参与项目

欢迎开发者审阅代码、报告可复现的问题，并提交改进建议。请在 Issue 中提供软件/编辑器版本、复现步骤和不含密钥或私人素材的日志。代码变更说明、完整使用指南及双语更新文档均可在 `docs/` 查看。

**重要：** 当前随附的 `NexForge-3.0.1-Source.zip` 是较早的源码快照，未包含 2026-11-28 这轮文档所列的全部代码改动；本次未收到与新安装包对应的更新源码包，因此没有将旧源码包冒充为匹配的新源码。应用 `package.json` 许可仍为 `UNLICENSED`；公开可下载不等于已授予自由复制、修改或再发布的许可证。KayKit 模板的 CC0 声明仅适用于该模板素材。

## English

### What’s new in this 3.0.1 update

- **More reliable asset recognition:** UE assets prefer serialized type metadata over filename-only guesses. Images, audio/video, models, Blender projects, UE projects, and native assets are presented by type. Covers prefer embedded or matching nearby images; recognition status is distinct from preview status.
- **Native motion templates:** Index animation sequences, montages, composites, blend spaces, aim offsets, and pose assets from animation files, UE projects, and package folders. Skeletons and animation Blueprints are distinguished from playable clips. Twelve KayKit starter motions retain their source and CC0-1.0 information; retargeting may be needed for other characters.
- **Animated previews and large-list usability:** Motion cards play on hover and stop when the pointer leaves. UE motion assets can reuse preview caches. Visible-range rendering and scrolling improve large template libraries.
- **Blender / UE installation and connection:** “Install and connect” detects running editors and projects, with user selection when multiple targets exist. Blender uses version-appropriate plugin locations and a managed startup loader. The UE bridge installs into the selected project and may ask you to save and reopen it. The first plugin installation usually requires restarting the relevant editor.
- **Reviewable workflow:** The AI assistant still requires a configured API or local model. An editor connection does not configure an AI provider; confirm the target and scope before writing to a real project.

### Fixes, verification, and scope

Fixes address UE animations misclassified as materials, native motion unavailable while UE is closed, static motion cards, missing scrolling, large-list slowdowns, duplicate connection bars after search, playback interrupted by rescans, cumbersome plugin setup, and multi-window session mix-ups. See [Code changes and bug fixes](docs/02-代码变更与Bug修复-中英双语.md) for affected modules and interfaces.

The final development regression run passed **60 application tests and 12 Python bridge tests**. Real-editor checks covered UE 5.9 and Blender 4.2.2 connections and scene reads. The Game Animation Sample index produced 2,288 motion/pose entries; this is an index count, not a claim that every entry has an animated preview. First-time UE preview generation requires the owning project, bridge, preview skeletal mesh, and local Blender.

This is not a complete game or universal renderer. Unsupported UE packages, cooked/encrypted assets, missing dependencies, and untested editor versions can affect recognition and previews. A fully automated Blueprint execution engine is outside this update. Automated test passes do not constitute end-to-end acceptance on every machine and project.

### Upgrade and use

1. Download the installer supplied with the [v3.0.1 Release](https://github.com/TianlongWorkshop/NexForge-AI-Game-Development-Workstation/releases/tag/v3.0.1), exit NexForge, and run it.
2. Preserve `%LOCALAPPDATA%/NexForge/Data`; do not delete or overwrite personal data when updating application files.
3. After launch, check Blender/UE connections in Settings. If first-time plugin setup asks for a restart, save your scene/project and reopen the same editor.
4. Configure an API or Ollama/LM Studio in Settings as needed. Editor bridges can work independently, but AI tasks need an available model.
5. Add files/folders in the asset library; import animation files, UE projects, or package folders in the motion library. Allow time for initial indexing and preview generation.

See the full [Upgrade and usage guide](docs/03-升级与使用指南-中英双语.md) for editor connections, asset imports, motion previews, safe deletion, and troubleshooting. The newly supplied installer still identifies as **3.0.1**; its SHA-256 is attached to the Release. This installer was not independently clean-installed during this publishing operation; review the supplied historical test report and the scope notes above.

### Get involved

Developers are welcome to review the code, report reproducible issues, and suggest improvements. When opening an issue, include app/editor versions, reproduction steps, and logs with secrets and private assets removed. Code-change details, full usage guidance, and bilingual update documents are in `docs/`.

**Important:** The currently attached `NexForge-3.0.1-Source.zip` is an earlier source snapshot and does not contain all code changes described for 2026-11-28. No matching updated source archive was supplied with this installer, so the older archive is not presented as matching source. The application package remains `UNLICENSED`; public availability does not grant permission to freely copy, modify, or redistribute it. The KayKit CC0 notice applies only to those motion assets.
