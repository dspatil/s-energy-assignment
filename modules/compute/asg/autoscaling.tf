resource "aws_launch_configuration" "web" {
  name                 = "web_lc"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  vpc_security_group_ids     = [module.security_groups.private_ec2_sg.id]
  user_data            = file("${path.module}/user_data.sh")
  key_name             = var.ssh_keypair_name
  root_block_device {
    volume_size = var.root_volume_size  # Size of root volume in GB
    encrypted   = true  # Enable encryption for root volume
  }

   block_device_mappings {
     device_name           = "/dev/xvdb"                  # Device name of the volume
     volume_size           = var.additional_volume_size           # Size of the volume in GB
     encrypted             = true
     delete_on_termination = true         
   }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                 = "web_asg"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 1
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = [module.vpc.private_subnet_id]
  health_check_type    = "EC2"


  // Autoscaling policies
  scaling_policy {
    name                   = "scale_out"
    adjustment_type        = "ChangeInCapacity"
    cooldown               = 300  # 5 minutes cooldown period
    scaling_adjustment     = 1    # Add 1 instance
    metric_aggregation_type = "Average"
    estimated_instance_warmup = 300  # 5 minutes estimated instance warm-up time
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        target_value           = 80
      }
    }
  }

  scaling_policy {
    name                   = "scale_in"
    adjustment_type        = "ChangeInCapacity"
    cooldown               = 300  # 5 minutes cooldown period
    scaling_adjustment     = -1   # Remove 1 instance
    metric_aggregation_type = "Average"
    estimated_instance_warmup = 300  # 5 minutes estimated instance warm-up time
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        target_value           = 40
      }
    }
  }
}
