#!/bin/bash

if noftiy-send "test"; then
	echo -e "\033[32m-*-\033[0m]]"
else
	echo -e "\033[31m-*-\033[0m]]"

sleep 1

if noftiy-send "test"; then
	echo -e "\033[32m-*-\033[0m]]"
else
	echo -e "\033[31m-*-\033[0m]]"
