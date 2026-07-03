.PHONY: setup update link help

help: ## 显示帮助
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n",$$1,$$2}'

setup: ## 首次安装：submodule + lark skills + 软链
	git submodule update --init --recursive
	npx skills add larksuite/cli -g -y
	bash scripts/link-agent-skills.sh

update: ## 更新：submodule + lark skills + 软链
	git pull --recurse-submodules
	npx skills add larksuite/cli -g -y
	bash scripts/link-agent-skills.sh

link: ## 一次性：挂载到 ~/.claude 和 ~/.claude-glm
	bash scripts/link-claude.sh
