.PHONY: pipenv-create
pipenv-create:
	pipenv sync

.PHONY: pipenv-update
pipenv-update:
	pipenv lock
	jq -r 'del(.default.selinux)' < Pipfile.lock > Pipfile.lock.new
	mv Pipfile.lock.new Pipfile.lock
	pipenv sync

.PHONY: test
test:
	pipenv run molecule test

.PHONY: generate-docs
generate-docs: pipenv-create
	pipenv run ansible-doctor ./
