// Output After Run
output "gke_cluster_name" {
  value       = google_container_cluster.cluster.name
  description = "GKE Cluster Name"
}

output "gke_cluster_endpoint" {
  value       = google_container_cluster.cluster.endpoint
  description = "GKE Cluster Endpoint"
}

output "gcloud_kubeconfig_command" {
  value       = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --region ${google_container_cluster.cluster.location} --project ${var.gcp_project_id}"
  description = "Command to create kubeconfig and connect to the GKE cluster"
}

# output "gke_namespace" {
#   value       = var.namespace
#   description = "GKE namespace used by the CD Infrastructure"
# }

# output "k8s_connector_id" {
#   value       = harness_platform_connector_kubernetes.gke_k8s.id
#   description = "Harness GKE Connector Id used by the CD Infrastructure"
# }