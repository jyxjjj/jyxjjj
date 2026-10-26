---
name: vscode-open
description: 用户要求使用 VSCode/code 打开项目、文件夹、文件，或执行 code 命令时，务必调用此技能。
---

# 使用 VS Code 打开

通过两次独立的 exec_command 调用执行：

1. 第一次执行 `getconf DARWIN_USER_TEMP_DIR`，读取命令输出，取得第二次调用要使用的 TMPDIR 实际值。
2. 第二次执行 `TMPDIR='<第一次调用输出的实际值>' code`，将占位内容替换为取得的实际值，并在 `code` 后附加用户要求的参数。实际值须按 shell 规则正确引用。

两次调用均必须设置 login=false 和 sandbox_permissions="require_escalated"，由工具权限机制审核后执行。

任一步失败或未取得目录值，直接报告打开 VS Code 失败。

完成后，输出第二步实际执行的完整命令，包含 TMPDIR 的实际值及传给 code 的全部参数。
