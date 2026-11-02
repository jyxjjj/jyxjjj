---
name: github-pr-review
description: 审核 GitHub Pull Request，在用户要求检查 PR 改动、核查影响或提供审核意见时使用。
metadata:
  short-description: GitHub PR 审核
---

# GitHub PR 审核

## 审核范围

- 从 PR 目标和 diff 出发，沿调用链核查改动对行为、接口、配置及测试的实际影响
- 按需读取未修改的调用方、被调用代码和上下文，不能只看 diff，也不扩展为全项目审计
- 以修改前行为和项目约定为基线，指出具体触发条件、影响和依据，不将猜测或个人偏好当作问题

## 审核规则

- 先查项目贡献规范、审核约定和 PR 模板，核对描述、必填项及项目明确要求
- 同时阅读 PR 评论区已有的审核信息，包括 review、行内评论及回复
- 阅读 CI 对 PR 的处理，核查触发条件、检查项目、跳过条件，以及当前 PR 的运行结果和失败日志
- 区分改动引入的问题、已有问题和 CI 执行问题，没法确定时明确说明，不把未运行当成通过
- 只提出有依据且值得处理的问题，建议与项目规范和当前实现一致
- GitHub 平台操作使用连接器，不使用 gh CLI

## 表达风格

- 结论优先，简短、直接、口语化，像开发者同步问题
- 先说哪里有问题、会影响什么，再补必要依据和修改建议，能概括就不展开
- 优先用“这里会……”“要改下……”“要看下……”“没法确定具体原因”等自然表达
- 避免“目前确认”“需要协助”“相关”“需要单独核对修正”等报告体措辞，除非确有必要
- 不堆调查过程、免责说明或未经证实的可能原因，不机械套用固定句式
- 使用本节固定风格，后续审核不为模仿口吻反复读取历史聊天

## 输出与提交

- 默认使用 [审核面板](assets/review-panel.html)，用户要求可复制版本时使用代码块输出正文
- 用户要求提交普通评论时，发布评论，用户要求 Request Changes 或 Approve 时，提交对应 review
- 仅要求审核或生成文案不代表授权发布，用户已明确要求提交时直接执行
- Request Changes 写明需要修改的具体问题，Approve 在审核支持通过时提交，存在阻断问题时先说明
- 发布正文使用下列署名，将占位内容替换为已确认的模型名称和推理强度，不猜测，Approve Only 不附正文和署名
- 先完成审核和正文，再按下列规则确认署名，确认后执行已授权的发布

### 审核面板

- 按模板生成本次面板，填入各 PR 的仓库、编号、中文极短描述和完整审核结果
- Model 和 Level 从 `${CODEX_HOME:-$HOME/.codex}/models_cache.json` 的 `display_name` 和 `supported_reasoning_levels[].effort` 读取
- 预选当前会话模型和推理强度，用户可修改，选择仅用于署名
- 用户通过面板发送提交指令后，按所选 PR、提交方式、正文和署名发布，逐项报告结果
- Approve Only：批准，不附正文
- Approve with Comment：批准，附审核结果及署名
- Request Changes：要求修改，附审核结果及署名
- Comment Only：普通评论，附审核结果及署名

### 署名确认

- 执行以下命令获取当前会话最新的模型名称和推理强度

  ```sh
  jq -r 'select(.type == "turn_context") | [.payload.model, .payload.effort] | @tsv' "$(rg --files "${CODEX_HOME:-$HOME/.codex}/sessions" -g "*${CODEX_THREAD_ID}.jsonl")" | tail -n 1
  ```

- 将结果按模型官方名称格式化，推理强度首字母大写，例如 `GPT-6.1-Sol Medium`
- 面板提交即确认所选署名，Approve Only 跳过署名确认
- 未使用面板时，通过 `functions.request_user_input` 询问“请问我是{模型名称} {推理强度}吗”，提供“是”“否”两个选项
- 用户选择“是”后用于署名，选择“否”或获取失败时请用户提供正确值，确认后执行已授权的发布

### Copy Only

只输出正文代码块，正文按上述表达风格编写。

```text
{审核意见}
```

### Comment Only

发布普通 PR 评论。

```text
{评论内容}

---
Reviewed or refined by {模型名称} {推理强度}
```

### Request Changes

以 Request Changes 提交，review 正文如下。

```text
{需要修改的问题、影响和必要建议}

---
Reviewed or refined by {模型名称} {推理强度}
```

### Approve Only

提交 Approve，不附正文和署名。

### Approve with Comment

提交 Approve，附带以下 review 正文。

```text
{审核意见}

---
Reviewed or refined by {模型名称} {推理强度}
```
