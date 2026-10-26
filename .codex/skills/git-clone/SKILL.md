---
name: git-clone
description: "读取用户现有的 `git new` 和 `git url` alias 定义，并按真实定义克隆远程仓库、创建或初始化本地 Git 仓库、设置首次 remote。仅当用户要求克隆、创建或初始化仓库时使用；不要用于普通 status、diff、branch、fetch、pull、commit、push 或 PR 任务。"
---

# Git Clone

在 login shell 中读取 alias 的真实定义，不要根据示例猜测：

```zsh
git config --get alias.new
git config --get alias.url
```

根据读取结果和用户提供的实际目录、remote URL 执行对应命令。可以直接调用 alias，也可以按 alias 定义手动执行。

- 克隆已有仓库后正常执行所需的 `git fetch`、`git pull` 或 checkout。
- 新建仓库时只完成用户要求的初始化和 remote 设置。
- 目标目录已存在、非空或已经是 Git 仓库时，不要覆盖或重新初始化。
- 除非用户明确要求，不要自动 commit、push 或创建 PR。
