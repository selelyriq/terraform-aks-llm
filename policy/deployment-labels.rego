package main

deny contains msg if {
  input.kind == "Deployment"
  object.get(input.spec.template.metadata, "labels", {}) == {}
  msg := "Deployments must have labels"
} 