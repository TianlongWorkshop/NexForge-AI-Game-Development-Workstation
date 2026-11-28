# NexForge 代码变更与 Bug 修复

代码版本 Code version：3.0.1  
更新日期 Update date：2026-11-28  
源码根目录 Source root：`Application/resources/app`

## 中文

本轮调整针对原生动画识别与导入、动态预览、画布外的滚动交互，以及专业软件的自动安装连接。用户交互在桌面前端完成，文件读取、插件安装和缓存由 Electron 主进程及配套桥接处理。

### 代码定位

以下路径均相对于源码根目录，列出本轮改动及主要相关模块。

| 文件或目录 | 职责 |
| --- | --- |
| `ue-package.cjs` | 有界读取 UE 包内注册信息，提取主资产类型与动作标签并缓存。 |
| `asset-classify.cjs` | 优先真实类型，必要时使用命名线索，保留分类依据和置信状态。 |
| `library.cjs` | 资产来源、封面、媒体读取、原生元数据、动作标记和索引刷新。 |
| `ue-assets.cjs` | 工程挂载目录、离线原生索引、在线 Asset Registry 补充和动作引用导入。 |
| `motion-library.cjs` | 模板、原生引用、移除状态、预览请求和缓存管理。 |
| `motion-preview.cjs` 与 `motion-preview.py` | 排队生成动作图集；UE 输入使用真实姿态采样。 |
| `vault-assets.cjs` | 读取 Epic 清单、检查本地文件和展开资源包，清单检查在工作线程执行。 |
| `main.cjs` | 文件、工程和文件夹导入，连接资产库与动作库的本地 IPC 接口。 |
| `ui/framework-ui.js` | 模板可见范围绘制、滚动保持、悬停播放、卡片复用和连接目标选择。 |
| `ui/framework-ui-motion.css` | 动作页滚动、连接状态排版和目标选择对话框。 |
| `v3/local-apps.cjs` | 已打开软件识别、Blender 启动加载器、UE 启用配置及即时激活尝试。 |
| `v3/service.cjs` 与 `v3/hub.cjs` | 安装连接流程、状态、自动重连和多窗口会话目标匹配。 |
| `v3/unreal/AIGWBridge` 与 `v3/blender/aigw_bridge` | 编辑器内工具、场景读取、本地会话及 UE 动作姿态采样。 |
| `tests` | 文件识别、动作导入、安装连接、协议、权限和回归检查。 |

### Bug 修复

| 原问题 | 原因 | 当前处理 |
| --- | --- | --- |
| UE 动画误判成材质 | 文件名前缀和依赖类名被用来推断主资产类型 | 优先读取包内主资产注册信息。 |
| 关闭 UE 后原生动作不能入库 | 导入依赖在线资产目录 | 增加离线工程与文件夹索引，在线数据继续补充。 |
| 资源包展开后只有普通文件 | 展开流程未连接动作导入 | 把识别出的原生动作接入模板库。 |
| 动作筛选漏掉 UE 文件 | 原生分类未同步动作标记 | 更新 isMotion 与稳定动作 ID。 |
| 动画资产卡片不动 | 未复用动作预览流程 | 资产卡片与动作模板共享缓存。 |
| 动作库不能下滚 | 画布容器隐藏溢出内容 | 页面、模板列表和导航分别支持垂直滚动。 |
| 大型模板库卡顿 | 同时创建全部卡片 | 只绘制可见范围和附近卡片。 |
| 搜索后连接栏重复 | 模板面板替换时重复生成连接栏 | 分离二者的生成和更新。 |
| 扫描刷新打断悬停播放 | 重建 DOM 断开正在播放的卡片 | 按资产 ID 和渲染状态复用未变化卡片。 |
| 连接前仍要手动安装 | 主按钮仅执行连接 | 统一识别、安装、启用和连接入口。 |
| UE 插件复制后未启用 | 工程描述缺少明确启用配置 | 备份并补齐插件与依赖，兼容时即时启动。 |
| Blender 安装后仍需手动勾选 | 缺少自动加载入口 | 安装启动加载器，首次重开后自动启动。 |
| 多窗口读到错误会话 | 只依赖一个默认会话文件 | 增加每进程会话文件及目标身份过滤。 |

### 主要接口

| 接口 | 用途 |
| --- | --- |
| `motionLibraryImport` / `motionLibraryImportPaths` | 导入动画文件、原生资产或 UE 工程。 |
| `motionLibraryImportFolder` | 导入 UE 工程或动作资源包文件夹。 |
| `motionLibraryPreview` / `libraryMotionPreview` | 获取或生成模板及资产卡片的预览。 |
| `vaultAssetsExpand` | 展开下载资源包并接入可识别动作。 |
| `ueAssetsSync` | 同步当前可连接工程。 |
| `v3Connect` / `v3InstallAndConnect` | 共用自动安装连接流程，返回已连接、选择目标或等待重开的状态。 |
| `v3Disconnect` | 断开连接并关闭该项自动连接偏好。 |

### 实现和数据边界

1. 模板、原生元数据和封面缓存在应用数据目录，通常为 `%LOCALAPPDATA%/NexForge/Data`。测试可用 `AIGW_DATA_DIR` 隔离数据。
2. 外部 UE 读取器只读取受支持的包头和注册信息，不加载完整模型或执行 UE 对象。格式和读取大小有边界，不支持的包保留降级显示。
3. UE 动态预览先通过桥接采样真实姿态，再调用本地 Blender 生成图集。限制预览生成并发，复用缓存；源文件变化会使相关预览失效。
4. UE 即时启用使用已开放的本机兼容 MCP Python 接口，并核对当前工程。它不注入进程，也不为此开启新的网络远程执行服务。接口不可用时提示保存并重开。
5. Blender 启动加载器不打开场景、不保存用户偏好；后台预览进程不会通过它自动开启桥接。
6. “从库中移除”保留源文件；删除磁盘源文件是另一个需要明确确认的操作。所属 UE 工程已连接时，检查引用后通过编辑器删除；未连接时会提示无法检查引用，并按确认结果移入回收站。

### 验证记录摘要

最终自动检查为 60 项应用测试和 12 项 Python 桥接测试，均通过。新增检查覆盖启用配置、工程备份、Blender 加载器、多工程选择和会话目标匹配。

本机 Game Animation Sample 检查了 3,895 个 UE 包，生成 3,881 条有效类型记录，其中 2,288 项属于动作与姿态模板。未解析项保留降级处理；该数字不代表全部模板都已生成动态预览。

真实编辑器验证环境为 UE 5.9 与 Blender 4.2.2。真实窗口验证涵盖滚动、搜索、动态缩图、重扫后的播放保持，以及编辑器场景读取。其他版本不能据此视为已经完成同等真实窗口验证。

开发者在源码根目录运行现有回归命令：

```powershell
node --test tests/*.test.cjs
python tests/test_blender_bridge.py
```

### 源码发布交接

保留源码、桥接、测试、依赖描述，以及模板来源和许可文件。本次另行收到的 3.0.1 安装程序已作为更新构建发布；本次发布操作没有从源码重新构建或独立干净安装该安装程序。当前公开源码 ZIP 仍是较早快照，不包含本轮全部代码改动。

发布时不要上传用户工程、VaultCache 原始资源、个人配置、密钥、含令牌的会话文件、日志和本机测试证据。本文件提供代码位置与改动说明，不是源代码压缩包。

当前 package.json 的许可字段仍为 UNLICENSED，本轮未修改软件许可。KayKit 模板单独保留 CC0-1.0 声明，其许可不代表整个应用的许可。

## English

This patch addresses native animation indexing, animated previews, scrolling outside the canvas, and automatic editor installation and connection. Desktop interactions remain in the UI, while Electron and the editor bridges perform local file access, installation, and caching.

### Code map

Paths are relative to `Application/resources/app` and include this update and its principal supporting modules.

| File or directory | Responsibility |
| --- | --- |
| `ue-package.cjs` | Bounded reading and caching of primary asset types and motion tags. |
| `asset-classify.cjs` | Real types before naming heuristics, with classification basis and confidence. |
| `library.cjs` | Sources, covers, media access, native metadata, motion flags, and rescanning. |
| `ue-assets.cjs` | Project mounts, offline indexing, live metadata, and native motion references. |
| `motion-library.cjs` | Templates, references, removal state, preview requests, and caches. |
| `motion-preview.cjs` and `motion-preview.py` | Queued preview sheets using real sampled UE poses. |
| `vault-assets.cjs` | Epic manifests and local package expansion, with worker-based inspection. |
| `main.cjs` | File, project, and folder import IPC and asset-to-motion integration. |
| `ui/framework-ui.js` | Visible-range rendering, scrolling, hover playback, card reuse, and target selection. |
| `ui/framework-ui-motion.css` | Motion scrolling and connection UI styling. |
| `v3/local-apps.cjs` | Running-editor detection, the Blender loader, and UE enablement and activation. |
| `v3/service.cjs` and `v3/hub.cjs` | Connection workflow, status, reconnection, and session identity matching. |
| Editor bridge directories under `v3` | Editor tools, local sessions, scene reads, and UE pose sampling. |
| `tests` | Recognition, motion, installation, protocol, permission, and regression checks. |

### Bug fixes

| Failure | Cause | Updated behavior |
| --- | --- | --- |
| Animation was classified as a material | Prefixes and dependency names inferred the primary type | Prefer primary asset registry metadata. |
| Closed projects could not provide templates | Import depended on the live registry | Add offline project and folder indexing. |
| Expanded packages produced only generic assets | Expansion was not connected to motion import | Route recognized native motion into templates. |
| The motion filter missed UE assets | Native types did not update motion flags | Populate flags and stable motion IDs. |
| Animation cards had static covers only | No shared motion preview workflow | Reuse the template preview cache. |
| The motion page could not scroll | Canvas layout hid overflow | Provide page, list, and navigation scrolling. |
| Large libraries stalled rendering | Every card entered the DOM at once | Render the visible range and nearby cards. |
| Search duplicated the connection bar | Panel replacement also regenerated the bar | Separate their updates. |
| Refresh interrupted playback | Rebuilding disconnected the playing card | Reuse unchanged cards by ID and render state. |
| Users still installed plugins manually | The main button only connected | Unify detection, installation, enablement, and connection. |
| A copied UE plugin remained disabled | Explicit project flags were missing | Back up and update plugin and dependency flags. |
| Blender still required manual activation | No automatic loading entry point | Install a startup loader for subsequent launches. |
| Multiple windows shared the wrong session | Only one default session file was used | Add per-process sessions and identity filtering. |

### Main interfaces

| Interface | Purpose |
| --- | --- |
| `motionLibraryImport` / `motionLibraryImportPaths` | Import animation files, native assets, or UE projects. |
| `motionLibraryImportFolder` | Import a UE project or motion-package folder. |
| `motionLibraryPreview` / `libraryMotionPreview` | Fetch or generate previews for both libraries. |
| `vaultAssetsExpand` | Expand packages and index recognizable motion. |
| `ueAssetsSync` | Synchronize the connectable project. |
| `v3Connect` / `v3InstallAndConnect` | Return connected, target-selection, or reopen-required states. |
| `v3Disconnect` | Disconnect and disable automatic connection for that entry. |

### Runtime boundaries

Templates and caches normally live in `%LOCALAPPDATA%/NexForge/Data`; tests can use `AIGW_DATA_DIR`. The UE reader handles bounded, supported metadata layouts without loading models or executing UE objects. Unsupported packages retain fallback display.

UE previews sample real poses, then use local Blender to render cached sprite sheets. Generation is concurrency-limited, caches are reused, and source changes invalidate affected previews.

Immediate UE activation uses an already-enabled local MCP Python interface and verifies project identity. It does not inject into the editor or enable a new network remote-execution service. Otherwise, the UI requests saving and reopening.

The Blender loader does not open scenes or save user preferences, and background preview processes do not start the bridge through it. Removing a library reference retains the source; deleting the disk file is a separate confirmation-based operation. A connected owning UE project allows reference checks and editor-side deletion. Without that connection, the confirmation warns that references cannot be checked before moving files to the recycle bin.

### Verification

The final run passed 60 application tests and 12 Python bridge tests. Added coverage includes plugin flags, project backups, the Blender loader, project selection, and session identity.

The local Game Animation Sample check examined 3,895 UE packages, produced 3,881 valid type records, and classified 2,288 motion or pose templates. Unsupported entries retain fallback handling. Not every template has a generated animated preview.

Real editor checks used UE 5.9 and Blender 4.2.2 and covered scrolling, search, preview playback, rescanning, and scene reads. This does not establish equivalent real-window verification for every other version.

Run the existing regression commands from the source root:

```powershell
node --test tests/*.test.cjs
python tests/test_blender_bridge.py
```

### Publication handoff

Retain source, bridges, tests, dependency descriptions, and template provenance and license files. The separately supplied 3.0.1 installer is published as the updated build; this publishing operation did not rebuild it from source or independently clean-install it. The currently published source ZIP remains an earlier snapshot and does not include all changes in this patch.

Exclude user projects, original VaultCache assets, personal settings, credentials, token-bearing sessions, logs, and local test evidence from a public upload. This document is a code-location guide, not a source archive.

The package.json license field remains UNLICENSED; this patch does not change the application license. The KayKit templates retain a separate CC0-1.0 declaration, which does not license the whole application.
