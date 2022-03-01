#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This library determines the OS Distribution
#  value, which is used in the RPM naming
#  strategy.
# It is imported by Global_Vars.resource.
#
f = open("/etc/rpm/macros.dist")
array = f.read().split()
index = [i for i in range(len(array)) if "%dist" == array[i]][0]
DIST = array[index + 1]
