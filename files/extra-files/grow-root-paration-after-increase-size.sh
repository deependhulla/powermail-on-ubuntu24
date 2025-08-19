#!/bin/bash

df -h
## Expand the partition. Use a proper partition number. In my case, I should expand /dev/sda2.
growpart /dev/sda 2
## Confirm the partition has been expanded.
gdisk -l /dev/sda
## Expand the file system. 
xfs_growfs /
## Confirm the file system has been expanded.
df -h
