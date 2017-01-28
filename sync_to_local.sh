#!/bin/bash

rsync -a --exclude=*.swp config/ ${HOME}
