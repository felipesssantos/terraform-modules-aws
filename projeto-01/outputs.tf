output "alb_dns" {
  description = "URL do Balancer para acessar do navegador"
  value       = module.meu_balancer.alb_dns_name
}
