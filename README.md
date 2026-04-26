# Claude Code Agent Hub

一组可复用的 Claude Code 自定义命令（Commands）和技能（Skills），用于提升日常开发工作流效率。

## 项目结构

```
├── commands/
│   ├── commit.md              # Git 提交助手：自动生成 Conventional Commits 格式的提交信息
│   └── go-code-review.md      # Go 代码审查：覆盖设计、错误处理、并发安全、性能等维度
└── skills/
    └── codex-code-review/     # 基于 OpenAI Codex CLI 的代码审查技能
        ├── SKILL.md
        ├── scripts/review.sh
        └── references/
            ├── codex_cli.md
            └── review_prompts.md
```

## Commands

### `/commit`

分析 `git diff --cached` 的暂存变更，自动生成符合 [Conventional Commits](https://www.conventionalcommits.org/) 规范的提交信息，确认后执行提交。

```
/commit
```

### `/go-code-review`

资深 Go 工程师视角的全面代码审查，支持两种模式：

- **目录模式** — 审查指定路径下所有 `.go` 文件
- **Diff 模式** — 无参数时自动审查当前未提交的变更

```
/go-code-review ./internal/service    # 目录模式
/go-code-review                        # Diff 模式
```

审查维度：代码设计 · 错误处理 · 并发安全 · 性能 · 可读性与规范。输出按高/中/低优先级排序的改进建议。

## Skills

### codex-code-review

集成 OpenAI Codex CLI 进行自动化代码审查，支持多种审查类型：

| 类型 | 说明 |
|------|------|
| Staged / Unstaged | 审查暂存或未暂存的变更 |
| Branch diff | 对比分支差异 |
| Directory | 审查整个目录 |
| PR review | 审查 Pull Request |
| Security / Performance | 专项安全或性能审计 |

附带 20+ 场景化 Prompt 模板（通用、语言专项、安全、性能、架构等）。

## 使用方式

将本仓库克隆到本地，在 Claude Code 的项目配置中引用 `commands/` 和 `skills/` 目录即可使用。

## License

MIT
