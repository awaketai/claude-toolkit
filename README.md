# Claude Code Agent Hub

一组可复用的 Claude Code 自定义命令（Commands）和技能（Skills），用于提升日常开发工作流效率。

## 项目结构

```
├── commands/
│   ├── commit.md              # Git 提交助手
│   └── go-code-review.md      # Go 代码审查
├── skills/
│   ├── codex-code-review/     # 直接提交：Codex CLI 代码审查
│   ├── munger-skill/          # submodule：芒格思维框架
│   ├── nuwa-skill/            # submodule：女娲造人 skill 生成
│   ├── paul-graham-skill/     # submodule：Paul Graham 思维框架
│   ├── steve-jobs-skill/      # submodule：乔布斯思维框架
│   ├── trump-skill/           # submodule：特朗普思维框架
│   └── lark-*/                # 脚本软链：飞书 API skills（npx skills add 安装）
├── scripts/
│   ├── link-agent-skills.sh   # 把 ~/.agents/skills/* 软链进 skills/
│   └── link-claude.sh         # 挂载到 ~/.claude/ 和 ~/.claude-glm/
└── Makefile                   # make setup / update / link
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

## 安装

```bash
git clone --recurse-submodules <本仓库地址>
cd claude-toolkit
make link    # 一次性：挂载到 ~/.claude/skills（和 ~/.claude-glm）
make setup   # 拉取 submodule + 安装 lark skills + 建软链
```

更新 skills：

```bash
make update
```

> 新增自编写 skill：放入独立 GitHub 仓库后 `git submodule add <url> skills/<name>`。
> 新增第三方 skill（lark 类）：`npx skills add <pkg> -g -y` 后重跑 `make setup`。

## License

MIT
