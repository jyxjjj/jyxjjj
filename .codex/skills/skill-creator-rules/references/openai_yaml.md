# 界面元数据格式

agents/openai.yaml 供宿主读取，包含界面元数据、工具依赖和调用策略。

- 字符串值加引号，键名不加引号
- default_prompt 使用简短调用示例，必须包含 `$技能名`

## interface

- display_name：界面显示名称
- short_description：供快速浏览的简短说明，25–64 个字符
- default_prompt：调用技能时插入的默认提示
- icon_small：小图标素材路径，相对于技能目录，通常放在 assets 中
- icon_large：大图标素材路径，相对于技能目录，通常放在 assets 中
- brand_color：十六进制品牌颜色

## dependencies.tools

- type：依赖类型，目前仅支持 mcp
- value：工具或依赖标识
- description：用途说明
- transport：MCP 传输方式，如 streamable_http
- url：MCP 服务地址

## policy

- allow_implicit_invocation：默认为 true，设为 false 时仅允许显式调用，技能仍可通过 `$技能名` 使用
