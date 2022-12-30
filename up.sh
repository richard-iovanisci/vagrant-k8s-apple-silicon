#!/bin/bash

# Manual Sequential Execution of Vagrant Provisioning
vagrant up k8s-master && vagrant up node-1 && vagrant up node-2
