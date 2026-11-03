---
name: before-fork-subagent
description: 用户明确要求使用 SubAgent 时调用。
---

## SubAgent 启动条件

仅在以下条件成立时启动 SubAgent：

- 用户明确要求使用 SubAgent、并行 Agent、独立 Agent 或进行任务委派
- 不得仅因为任务复杂、耗时、可并行或使用 SubAgent 可能提高效率而自行启动
- 如果用户在当前请求中已经明确要求使用 SubAgent、独立 Agent 或浏览器 Agent，不得再次询问相同授权
- 满足上述启动条件后，按 Fork 配置启动 SubAgent

### Fork 配置

除非用户明确指定其他值，否则：

- `fork_turns` 必须设为 `none`
- Main Agent 必须在委派消息中提供完成任务所需的完整目标、上下文、约束、输入和输出要求
- SubAgent 不得依赖未传递的对话历史
