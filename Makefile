SHELL := /bin/bash -o pipefail -o errexit

lint:	lint-docker lint-sh

lint-docker:
	export LINT_ERRORS=0; \
	IFS=$$'\n'; for dockerfile in $(shell git ls-files | { grep Dockerfile || echo ""; }); do \
		docker run --rm -i -v "$$(pwd)":/workdir -w /workdir ghcr.io/hadolint/hadolint /bin/hadolint "$${dockerfile}" || LINT_ERRORS=$$((LINT_ERRORS+1)); \
	done; \
	exit "$${LINT_ERRORS}"

lint-sh:
	export LINT_ERRORS=0; \
	IFS=$$'\n'; for shellscript in $(shell git ls-files -z | xargs -0 file | grep "shell script" | cut -d: -f1 || echo ""); do \
		shellcheck --enable=all "$${shellscript}" || LINT_ERRORS=$$((LINT_ERRORS+1)); \
	done; \
	exit "$${LINT_ERRORS}"

.PHONY: $(MAKECMDGOALS)
