SHELL := /bin/bash -o pipefail -o errexit

lint:
	pre-commit run --all-files

.PHONY: $(MAKECMDGOALS)
