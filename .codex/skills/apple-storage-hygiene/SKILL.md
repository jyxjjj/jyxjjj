---
name: apple-storage-hygiene
description: "仅为用户自己拥有或明确负责维护的 Apple/Xcode 项目，在任务完成且改动明确可能新增或改变持久化写入时，于最终回复末尾提供针对当前项目的简短只读存储检查脚本调用命令。对第三方或他人的软件不要主动提示；项目归属不明确时也不要触发，除非用户显式要求检查该软件的存储痕迹。还须有代码或配置实际涉及 UserDefaults、文件或目录、数据库、cache、网络或 WebKit 数据、App Groups、iCloud/CloudKit、状态恢复、长期日志、helper、第三方 package 持久化。不要仅因任务涉及 Xcode、Swift、Objective-C、构建、测试或 Debug 而使用；不要自动执行存储检查或推断未观察到的写入。"
---

# Apple App 存储检查

先完成开发任务，再在最终回复末尾输出内置只读检查脚本的简短调用命令。不要复制脚本正文，也不要代替用户运行存储审计。

## 项目归属前置条件

仅对用户自己拥有或明确负责维护的项目主动追加存储检查提示。必须从当前任务上下文明确确认这种归属；本地存在源码、用户正在修改代码或用户向第三方项目贡献代码，均不能单独证明该项目属于用户。

对于第三方或他人的 App、开源项目、依赖、SDK、工具及其他软件，不要主动追加提示。项目归属不明确时，视为不满足前置条件；不要仅为追加提示而追问用户项目归属。

如果用户在当前请求中显式要求检查某个软件的存储痕迹，则不受项目归属限制。

## 触发边界

满足项目归属前置条件后，仅在以下任一条件成立时使用：

- 本次修改明确新增或改变持久化写入。
- 代码或配置明确涉及 UserDefaults、文件、目录、数据库、cache、网络存储、WebKit 数据、App Groups、iCloud/CloudKit、状态恢复、长期日志、helper 或第三方 package 持久化。
- 用户显式要求检查 Apple App 的存储痕迹。

不要仅因任务使用 Xcode、Swift、Objective-C、SwiftUI、构建、测试、运行或 Debug 而触发。

## 确认项目标识

优先复用本次任务已经确认的项目配置。必要时只读搜索和检查 `.pbxproj`、`.xcconfig`、Info.plist、entitlements 及相关源码，确认：

- 本次可能运行的 App、extension、XPC service 和 helper 的实际 bundle identifier。
- 实际 product name、display name 和 executable name。
- 所有相关 App Group identifier。
- 所有相关 iCloud 或 CloudKit container identifier。
- 代码或配置明确指定的自定义目录、数据库名、日志名和第三方 storage 名称。
- 是否涉及 login item、LaunchAgent、LaunchDaemon、privileged helper、system extension 或系统级安装。
- 代码是否明确使用 Keychain，以及实际 service 或 account 标识。

如果 build setting 含变量且无法从静态文件确认，使用当前实际可用的 Xcode MCP 工具读取对应 project 或 workspace、scheme 和 configuration 的 build settings。不要使用 `xcodebuild -showBuildSettings`，不要因此触发 build 或运行 App。

不得猜测标识。不得在最终调用命令中留下 `<bundle-id>`、`YOUR_APP`、`com.example` 或类似占位符。存在多个相关 target 时重复传递参数，不要只检查主 App。

如果无法确认必要标识，请用户提供 Xcode MCP 结果、项目配置、日志或截图；不要输出带猜测值的调用命令。

## 使用内置脚本

使用本 Skill 目录中的 `scripts/check-storage.zsh`。

输出最终命令时：

1. 根据当前 Skill 的实际位置解析脚本路径。
2. 使用 `zsh` 调用脚本，不依赖脚本的 executable mode。
3. 输出可直接粘贴到 macOS `zsh` 执行的代码块。
4. 所有参数必须来自已确认的项目事实。
5. 按需要重复同一种参数。
6. 不要在最终回复中展开或复制脚本正文。
7. 不要自动执行脚本。

支持的参数：

- `--bundle-id VALUE`：相关 App、extension、XPC service 或 helper 的 bundle identifier；可重复。
- `--app-name VALUE`：实际 product、display 或 executable name；可重复。
- `--app-group-id VALUE`：App Group identifier；可重复。
- `--icloud-container-id VALUE`：iCloud 或 CloudKit container identifier；可重复。
- `--custom-path PATH`：代码或配置明确使用的额外路径；可重复。
- `--include-system-locations`：仅当任务明确涉及 login item、LaunchAgent、LaunchDaemon、privileged helper、system extension 或系统级安装时添加。

不要为了“更完整”而传递未经确认的名称或路径。

## 脚本行为

内置脚本负责：

- 先打印收到的实际标识和路径，方便用户核对检查目标。
- 根据 bundle identifier、App 名称和 App Group 生成标准精确候选路径。
- 对存在的精确目录递归执行只读 `find`。
- 对存在的精确文件或符号链接打印路径。
- 在相关标准根目录第一层按已确认标识和名称搜索。
- 仅在传入 `--include-system-locations` 时检查系统级和 helper 相关位置。
- 不读取文件内容。
- 不修改或删除文件。
- 不使用 `sudo`。
- 不隐藏权限错误或其他异常。

iCloud 和 CloudKit 的实际磁盘映射可能由系统决定。脚本只在 Mobile Documents 第一层按已确认 container identifier 搜索，不虚构精确映射。

## Keychain

Keychain 不是普通文件夹。

仅当代码明确使用 Keychain 时，在脚本调用命令之后补充一句简短提醒，让用户通过 Keychain Access 按已确认的 service 或 account 检查。不要输出可能泄露凭据内容的 dump 命令。

## 结果边界

- 不宣称脚本找到的内容由本次 Debug 或运行创建；没有运行前后快照就无法确认归因。
- 不声称按名称搜索能够发现所有第三方或系统内部存储。
- 无标识内容只能结合用户提供的运行前后差异继续分析。
- 用户回传脚本输出后，再根据实际结果分析。
- 不要提前建议删除任何内容。
