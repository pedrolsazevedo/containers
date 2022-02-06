# Basic Templates
  I've created this repository to host my templates and materials for study in kubernetes.

## Wordpress
  My first template in thes repo is a model for a deployment of Wordpress CMS.
  It relies on Ngingx Ingress, Longhorn and Azure Files storage class.

  1. Description
    1.1 **`00-wp-namespace.yaml`**
      This file create the namespace to host all the artifacts created
    1.2  **`01-wp-pvc.yaml`**