---
name: browser-operation
description: 需要真实浏览器页面交互，或用户明确要求使用 Chrome 时，按用户授权流程委派独立 Agent 操作浏览器。
---

## 浏览器委派

本节所称 "浏览器操作" 指需要真实浏览器页面交互的任务，例如：

- 使用已有登录态
- 点击、输入、上传、下载或提交页面
- 操作仅能通过浏览器访问的 Web 应用
- 检查实际页面状态、可控 Tab 或浏览器扩展

普通公开网页搜索、无需登录的内容检索或直接 HTTP 获取，不属于本节所称的浏览器操作，除非用户明确要求使用 Chrome

当 Main Agent 判断任务需要浏览器操作时：

1. 如果用户尚未明确要求使用 SubAgent、独立 Agent 或浏览器 Agent，先询问用户是否使用独立 Agent 操作浏览器，仅要求使用 Chrome 时也按此流程询问
2. 用户明确同意或已明确要求使用独立 Agent 后，读取并遵循 `before-fork-subagent`，启动独立 SubAgent
3. 指示该 SubAgent 读取 Chrome 的 Codex 插件 SKILL，并依照该 Skill 操作
4. 优先选择 Browser List 中符合以下条件的浏览器：
   - `type=extension`
   - `name=Chrome`
   - `profile=神林`
5. 不得使用 Codex App 内置浏览器
6. 如果可控 Tabs 为空，优先尝试连接现有 Chrome 页面
7. 只有无法连接现有页面时，才新建页面，以尽量复用已有登录态

如果用户拒绝启动独立 Agent，则不得自行启动 SubAgent，也不得改用 Codex App 内置浏览器。Main Agent 应继续完成不依赖浏览器操作的部分，并明确指出无法执行的浏览器相关步骤

