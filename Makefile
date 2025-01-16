##=============================================================================
## [Filename]       Makefile
## [Project]        
## [Author]         Ciro Bermudez - cirofabian.bermudezmarquez@ba.infn.it
## [Language]       GNU Makefile
## [Created]        Dec 2024
## [Modified]       -
## [Description]    -
## [Notes]          -
## [Status]         devel
## [Revisions]      -
##=============================================================================

# ===============================  VARIABLES  =================================

# Makefile shell
SHELL := /bin/bash

# Miscellaneous variables
CUR_DATE   := $(shell date +%Y-%m-%d_%H-%M-%S)

# Directories
GIT_DIR     := $(shell git rev-parse --show-toplevel)
ROOT_DIR    := $(CURDIR)
RUN_DIR     := $(ROOT_DIR)/work
SCRIPTS_DIR := $(ROOT_DIR)/scripts

# Files
RTL_FILES = $(ROOT_DIR)/rtl/inverter.sv
TB_FILES = $(ROOT_DIR)/tb/tb.sv

# Vivado options
TOP = tb
FILES = $(RTL_FILES) $(TB_FILES)

XVLOG_DEFINES ?= 

XVLOG_FLAGS = -sv $(XVLOG_DEFINES) $(FILES) -log compile.log

XELAB_FLAGS = -top $(TOP) -debug all -timescale 1ns/100ps -log elaborate.log \
							-snapshot work.$(TOP) 

# -gui -view $(ROOT_DIR)/work.$(TOP).wcfg     this loads the waveform view
XSIM_FLAGS = work.$(TOP) -wdb work.$(TOP).wdb -log simulate.log

TCL_FLAGS = $(XSIM_FLAGS) -tclbatch $(ROOT_DIR)/run.tcl

# -view $(ROOT_DIR)/work.$(TOP).wcfg
WAVE_FLAGS = -gui work.$(TOP).wdb

# Colors
C_RED := \033[31m
C_GRE := \033[32m
C_BLU := \033[34m
C_YEL := \033[33m
C_ORA := \033[38;5;214m
NC    := \033[0m 

# Vivado tools
VIVADO_TOOLS := vivado xvlog xvhdl xelab xsim

# ================================  TARGETS  ==================================

.DEFAULT_GOAL := all

.PHONY: all
all: help
#______________________________________________________________________________

.PHONY: check-shell
check-shell:
	@echo "SHELL is use: $(SHELL)"
#______________________________________________________________________________

.PHONY: tools-check
tools-check: ## Check for missing tools
	@echo -e "$(C_ORA)Vivado tool checking...$(NC)"
	@for tool in $(VIVADO_TOOLS); do \
		if ! command -v $$tool >/dev/null 2>&1; then \
			echo -e "$(C_RED)Error: $(C_BLU)$$tool$(C_RED) is not installed or not in PATH$(NC)"; \
			exit 1; \
		else \
			echo -e "$(C_BLU)$$tool$(NC)\t is INSTALLED$(NC)"; \
		fi; \
	done
	@echo "All Vivado tools are available"
#______________________________________________________________________________

.PHONY: vars
vars: ## Print Makefile variables
	@echo ""
	@echo -e "$(C_ORA)Miscellaneous variables...$(NC)"
	@echo "CUR_DATE    = $(CUR_DATE)"
	@echo ""
	@echo -e "$(C_ORA)Directory variables...$(NC)"
	@echo "GIT_DIR     = $(GIT_DIR)"
	@echo "ROOT_DIR    = $(ROOT_DIR)"
	@echo "RUN_DIR     = $(RUN_DIR)"
	@echo "SCRIPTS_DIR = $(SCRIPTS_DIR)"
	@echo "VERDI_DIR   = $(VERDI_DIR)"
	@echo ""
	@echo -e "$(C_ORA)UVM variables...$(NC)"
	@echo "TEST        = $(TEST)"
	@echo "VERBOSITY   = $(VERBOSITY)"
	@echo "SEED        = $(SEED)"
	@echo "VCS_DEFINES = $(VCS_DEFINES)"
	@echo "SIMV_ARGS   = $(SIMV_ARGS)"
	@echo ""
#______________________________________________________________________________

.PHONY: compile
compile: ## Runs XVLOG
	@echo -e "$(C_ORA)Compiling project$(NC)"
	@mkdir -p $(RUN_DIR)/sim 
	cd $(RUN_DIR)/sim && xvlog $(XVLOG_FLAGS)
#______________________________________________________________________________

.PHONY: elaborate
elaborate: ## Runs XELAB
	@echo -e "$(C_ORA)Elaborating project$(NC)"
	@mkdir -p $(RUN_DIR)/sim 
	cd $(RUN_DIR)/sim && xelab $(XELAB_FLAGS)
#______________________________________________________________________________

.PHONY: sim
sim: ## Runs XSIM
	@echo -e "$(C_ORA)Running simulation$(NC)"
	cd $(RUN_DIR)/sim && xsim $(XSIM_FLAGS) &
#______________________________________________________________________________

.PHONY: sim-tcl
sim-tcl: ## Runs XSIM with tcl
	@echo -e "$(C_ORA)Running simulation with tcl$(NC)"
	cd $(RUN_DIR)/sim && xsim $(TCL_FLAGS) &
#______________________________________________________________________________

.PHONY: wave
wave: ## Load Waveform into XSim GUI
	@echo -e "$(C_ORA)Opening waveform$(NC)"
	cd $(RUN_DIR)/sim && xsim $(WAVE_FLAGS) &
#______________________________________________________________________________

.PHONY: random
random: ## Runs simv simulation using a random seed
	@echo -e "$(C_ORA)Running simulation with random seed$(NC)"
#______________________________________________________________________________

.PHONY: coverage
coverage: ## Create coverage report
	@echo -e "$(C_ORA)Creating coverage report$(NC)"
#______________________________________________________________________________

.PHONY: compile-dpi
compile-dpi: ## Run dpi (C/C++) compilation
	@echo -e "$(C_ORA)Compiling dpi (C/C++) code$(NC)"
	g++ -c dpi/external.cpp -o dpi/external.o
#______________________________________________________________________________

.PHONY: clean
clean: ## Remove all simulation files
	@echo -e "$(C_ORA)Removing all simulation files$(NC)"
	rm -rf $(RUN_DIR) dpi/*.o
#______________________________________________________________________________

.PHONY: help
help: ## Display help message
	@echo ""
	@echo "======================================================================"
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "--------------------------- Targets ----------------------------------"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "- make \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "--------------------------- Variables -------------------------------"
	@echo "  TEST                : Name of UVM_TEST"
	@echo "  VERBOSITY           : UVM_VERBOSITY of the simulation"
	@echo "  SEED                : Random seed used, must be an integer > 0"
	@echo "  VCS_DEFINES         : Add defines to vcs command"
	@echo "  SIMV_ARG            : Add plusargs to simv command"
	@echo ""
	@echo "---------------------------- Defaults --------------------------------"
	@echo "  TEST                : $(TEST)"
	@echo "  VERBOSITY           : $(VERBOSITY)"
	@echo "  SEED                : $(SEED)"
	@echo "  VCS_DEFINES         : $(VCS_DEFINES)"
	@echo "  SIMV_ARGS           : $(SIMV_ARGS)"
	@echo ""
	@echo "======================================================================"
	@echo ""

