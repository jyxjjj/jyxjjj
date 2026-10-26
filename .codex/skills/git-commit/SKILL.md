---
name: git-commit
description: "按自定义 Conventional Commits 规范生成、审查提交信息或执行提交；根据远程 URL 选择中英文，正文尽可能多列出独立改动。"
---

# Conventional Commits

## 消息语言

- 生成或审查提交信息前，仅允许将目标仓库的 Git 远程 URL 通过管道交给 `grep -q`、`rg -q` 等命令，依据退出状态判断是否托管在 GitHub
- 不得读取、输出或记录完整 URL，匹配命令必须只返回判断结果，不得输出匹配行
- GitHub 仓库的 subject 和正文使用英文，其他仓库的 subject 和正文使用中文
- 未指定时使用英文
- 不考虑CNAME，精确判断github.com或ssh.github.com
- type 保持规定的英文值，scope 保持实际模块、包名或功能名，代码标识符、专有名称及两行 trailers 保持原样，提交信息结构不变

## Title

```plain
type(scope): subject
```

- type 必须是：feat, fix, refactor, perf, docs, style, test, build, ci, chore, revert 之一
- scope 为主要模块、包名或功能名
- subject 使用祈使句，描述改动内容，语言遵循“消息语言”规则

## Description

```plain
- item 1
- item 2
- item 3
... (根据实际改动增加)
```

- 正文使用 Markdown 列表，每项以 `- ` 开头
- 在实际改动支持的范围内，尽可能多地列出具体、独立且有信息量的条目，充分覆盖改动细节
- 每项描述一个明确的改动；可独立说明的行为、逻辑、配置、文档或测试改动应分别列项
- 条目数量由实际改动决定，不设固定数量或上限；10 个、20 个或更多均可
- 不要为增加条目而重复表述、机械拆句或编造不存在的改动
- 语言遵循“消息语言”规则，每项简短明确
- 仅输出提交内容，不要解释
- 不要 markdown code block
- 签你自己名字：Co-authored-by: Codex <267193182+codex@users.noreply.github.com>
- 签署者信息：Signed-off-by: jyxjjj <16695261+jyxjjj@users.noreply.github.com>

## 完整提交示例

GitHub 仓库：

```plain
feat(auth): add JWT authentication

- Implement JWT authentication for secure API access
- Update the user model to support token generation
- Add tests for the authentication flow
- ... (根据实际改动增加)

Co-authored-by: Codex <267193182+codex@users.noreply.github.com>
Signed-off-by: jyxjjj <16695261+jyxjjj@users.noreply.github.com>
```

其他仓库：

```plain
feat(auth): 添加 JWT 身份验证

- 实现 API 访问的 JWT 身份验证
- 更新用户模型以支持令牌生成
- 添加身份验证流程的测试
- ... (根据实际改动增加)

Co-authored-by: Codex <267193182+codex@users.noreply.github.com>
Signed-off-by: jyxjjj <16695261+jyxjjj@users.noreply.github.com>
```

- 示例中的省略提示不属于实际提交内容，应按真实改动列出全部条目
- 不要使用多个 -m
- 不要使用 -F
- 直接在单个 -m 中换行
