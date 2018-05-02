#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ${ICD_HOME:-$HOME/icd}/tools/install_shared.sh
R CMD build --no-build-vignettes --no-resave-data icd

# or try --configure-args="CXXFLAGS=-O0"
R_MAKEVARS_USER="$HOME/.R/Makevars.mac.quick" \
MAKEFLAGS="-j8" \
  R CMD INSTALL -d \
    --no-clean-on-error \
    --library="$install_dir" \
    --install-tests \
    --no-docs \
    "$(ls -t icd*gz | head -1)"
