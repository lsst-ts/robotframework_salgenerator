#!/usr/bin/env python
# -*- coding: utf-8 -*-

f = open("/etc/rpm/macros.dist")
array = f.read().split()
DIST = array[10]
