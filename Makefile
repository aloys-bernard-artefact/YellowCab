
########################################################################################################################

# Setup virtual environment
ENV_NAME := $(shell echo $(notdir $(CURDIR)) | sed 's/^[0-9]*-//' | tr '[:upper:]' '[:lower:]')

.PHONY : setup, create-venv, install-requirements
setup : create-venv install-requirements

create-venv:
	@if ! pyenv virtualenvs | grep -q $(ENV_NAME); then pyenv virtualenv 3.10.12 $(ENV_NAME); \
	else echo "virtualenv already exists"; fi
	# Set virtualenv as local
	@pyenv local $(ENV_NAME)
	@echo "✅ Virtualenv $(ENV_NAME) created and set as local"

install-requirements:
	@pip install --upgrade pip --quiet
	@pip install -e . 
	@pip install -r requirements.txt 
	@echo "✅ Requirements installed"


########################################################################################################################

# Web and API

.PHONY : run_api
run_api:
	@uvicorn app.main:app --reload
