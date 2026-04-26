---
description: 分析暂存区变更，生成通用的 Conventional Commits 提交信息并在确认后提交。
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git commit:*)
---
1. 执行 `git status --short` 和 `git diff --staged`，确认当前工作区状态，并获取暂存区变更。
2. 如果暂存区为空，明确提示用户“当前没有已暂存的变更，请先执行 `git add` 后再提交”，并终止；不要继续生成 Commit Message。
3. 生成一条通用的 **Conventional Commits** Commit Message，不依赖任何仓库内约定。默认要求：
   - 使用格式：`type(scope): subject` 或 `type: subject`
   - `type` 应根据变更语义从 `feat`、`fix`、`refactor`、`docs`、`test`、`chore`、`build`、`ci`、`perf` 中选择最合适的一项
   - 仅在 scope 能显著提升可读性时使用；不要滥用 scope
   - `subject` 应简洁、具体，准确描述本次提交的主要意图，避免空泛表达，如 `update code`
   - 默认生成单行 message，除非用户明确要求带 body/footer
4. 在提交前，向用户展示：
   - 将要提交的文件范围仅为 **已暂存内容**
   - 候选 Commit Message
   - 如存在未暂存或未跟踪文件，明确说明这些内容 **不会** 包含在本次提交中
5. 询问用户是否确认提交。
6. 如果用户确认，执行 `git commit -m "..."` 完成提交。
7. 如果 `git commit` 执行失败，明确返回失败原因摘要（例如 hook 失败、没有 staged 变更、配置缺失等），不要误报为提交成功。
