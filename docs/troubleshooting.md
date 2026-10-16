# Troubleshooting: Kubernetes Pod Scheduling

## Problem

During deployment of Google's Online Boutique application to Amazon EKS, some Pods could not be scheduled because the cluster had insufficient available Pod capacity.

The Kubernetes scheduler reported:

`FailedScheduling: 0/1 nodes are available: 1 Too many pods`

## Investigation

The cluster had only one worker node. The node had reached its Pod capacity, preventing Kubernetes from scheduling additional application Pods.

I inspected the cluster's node and Pod status using `kubectl` and investigated the EKS managed node group's configuration.

## Solution

I increased the EKS managed node group's desired capacity from one worker node to two using the AWS CLI.

This added another worker node, giving Kubernetes additional capacity to schedule the pending Pods.

## Verification

After scaling the node group, I checked the node status and confirmed that both worker nodes were `Ready`. I then checked the application Pods to verify that scheduling could proceed.

## Lessons Learned

- Kubernetes scheduling depends on available resources and node-level limits.
- A Pod scheduling error does not necessarily mean the application itself is broken.
- Checking `kubectl describe pod` and `kubectl get nodes` helps identify scheduling problems.
- EKS managed node groups can be scaled when additional worker capacity is needed.
- Increasing capacity can increase AWS costs, so node scaling should be monitored.
