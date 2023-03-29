output "name" {
  description = "The name of the control tower control"
  value       = aws_controltower_control.this.id
}

output "control_identifier" {
  description = "The control identifier of the control tower control"
  value       = aws_controltower_control.this.control_identifier
}

output "target_identifier" {
  description = "The target identifier of the control tower control"
  value       = aws_controltower_control.this.target_identifier
}
