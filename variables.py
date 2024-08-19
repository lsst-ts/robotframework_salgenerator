#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This library determines the OS Distribution
#  value, which is used in the RPM naming
#  strategy.
# It is imported by Global_Vars.resource.
#
f = open("/etc/os-release")
array = f.read().split()
index = [i for i in range(len(array)) if "PLATFORM_ID" in array[i]][0]
DIST = "." + array[index].split(":")[1].strip("\"")
