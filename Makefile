SHELL := /bin/bash -o pipefail -o errexit

lint-docker:
	export LINT_ERRORS=0; \
	IFS=$$'\n'; for dockerfile in $(shell git ls-files | { grep Dockerfile || echo ""; }); do \
		docker run --rm -i -v "$$(pwd)":/workdir -w /workdir ghcr.io/hadolint/hadolint /bin/hadolint "$${dockerfile}" || LINT_ERRORS=$$((LINT_ERRORS+1)); \
	done; \
	exit "$${LINT_ERRORS}"

.PHONY: $(MAKECMDGOALS)