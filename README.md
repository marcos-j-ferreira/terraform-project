## Terraform Block Structure

Terraform files (`.tf`) are structured using blocks. A general block looks like:

```hcl
block_type "label" {
  argument = value
  nested_block {
    argument = value
  }
}
```

Explanation:

* `block_type`: What you're defining (e.g. `resource`, `provider`, `variable`)
* `"label"`: An identifier (e.g. resource type and name)
* `argument = value`: Key-value pairs configuring the block
* `nested_block`: Sub-configuration inside some blocks (e.g. `ingress` inside a security group)

---

## File Overview

The entire configuration is in one file: `main.tf`

It includes:

1. `terraform` block – required provider info
2. `provider` block – cloud provider setup
3. `variable` blocks – user-defined inputs
4. `locals` block – internal reusable values
5. `resource` blocks – infrastructure (EC2 + security group)
6. `output` blocks – return useful values after deployment

---

## Key Syntax Elements Explained

### 1. **Terraform Block**

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

* Tells Terraform which **provider** plugin to use
* `~> 5.0` means "compatible with any 5.x version"

---

### 2. **Provider Block**

```hcl
provider "aws" {
  region = var.region
}
```

* Configures the **AWS provider**
* Uses a variable (`var.region`) so it's flexible

---

### 3. **Variable Block**

```hcl
variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}
```

* Defines input values for configuration
* `default` is optional — allows hardcoded fallback

---

### 4. **Locals Block**

```hcl
locals {
  common_tags = {
    Project = "TerraformLearning"
    Env     = "test"
  }
}
```

* Stores reusable internal values
* Good for **tags**, **name prefixes**, or computed values
* Used with `merge()` to combine with other tags

---

### 5. **Resource Block**

```hcl
resource "aws_instance" "testEC2" {
  ami           = "ami-0xxxxx"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = merge(local.common_tags, {
    Name = "TerraformTestServer"
  })
}
```

* `resource`: defines something to deploy
* `"aws_instance"`: resource type
* `"testEC2"`: internal name for reference
* Uses **variables**, **locals**, and references to other resources

---

### 6. **Nested Blocks (Ingress/Egress)**

```hcl
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```

* Used inside some resources like `aws_security_group`
* Define **detailed configuration** (e.g., network rules)

---

### 7. **Output Block**

```hcl
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.testEC2.public_ip
}
```

* Used to **return values** after `terraform apply`
* Great for displaying IPs, IDs, or passing data to other tools

---

## Best Practices Shown in This Project

| Practice                   | Example                                                     |
| -------------------------- | ----------------------------------------------------------- |
| Use of `variable`          | Makes the configuration flexible and reusable               |
| Use of `locals`            | DRY approach for tags and repeated values                   |
| Descriptive names and tags | Easier management and readability                           |
| `merge()` function         | Combines local tags with custom ones                        |
| Output values              | Returns info useful after deployment                        |
| Modular structure          | Separates logic cleanly (could be split into modules later) |

---

