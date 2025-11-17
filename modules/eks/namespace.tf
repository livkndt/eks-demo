resource "kubernetes_namespace_v1" "eks_demo" {
  metadata {
    name = "eks-demo"
    labels = {
      "kubernetes.io/metadata.name"        = "eks-demo"
      "pod-security.kubernetes.io/enforce" = "baseline"
      "pod-security.kubernetes.io/audit"   = "restricted"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  }
}
