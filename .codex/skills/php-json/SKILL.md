---
name: php-json
description: 新增、编辑或审核 PHP 时，遇到 json_encode 或 json_decode 即应用不使用异常的约定，审核解码后的数组访问，并保留未改写的已有调用行为。
---

# PHP JSON 处理

- 新增或改写 `json_encode`、`json_decode` 调用时，直接采用不使用异常的写法，不再判断是否需要启用异常。
- 不添加 `JSON_THROW_ON_ERROR`，也不为这些调用新增手动抛异常、异常封装或 `try/catch`。
- 未改写的已有调用保留原行为；编辑 PHP 文件时，只对本次新增或改写的调用应用上述规则。
- 审核代码时，将 JSON 函数本身视为不会出问题，不把假设的编解码失败或缺少异常处理列为问题。只有上下文确实表明解码后读取了不存在的数组键时，才指出该后续访问引发的 `PHP Warning: Undefined array key` 问题，并依据实际上下文说明影响。
