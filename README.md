ALB basicauth target group Terraform module
====================================================================================================

This terraform module creates an ALB basic auth target group

Usage
----------------------------------------------------------------------------------------------------

```hcl
module "alb-basicauth" {
  source = "KazuyaMiyagi/alb-basicauth/aws"
  name   = "alb-basicauth
}
```

Examples
----------------------------------------------------------------------------------------------------

* [Simple](https://github.com/KazuyaMiyagi/terraform-aws-alb-basicauth/tree/master/examples/simple)

Requirements
----------------------------------------------------------------------------------------------------

| Name      | Version    |
|-----------|------------|
| terraform | >= 0.12.\* |
| aws       | >= 3.12.\* |

Providers
----------------------------------------------------------------------------------------------------

| Name | Version    |
|------|------------|
| aws  | >= 3.12.\* |

Inputs
----------------------------------------------------------------------------------------------------

| Name  | Description   | Type     | Default           | Required |
|-------|---------------|----------|-------------------|:--------:|
| name  | Resource name | `string` | `"alb-basicauth"` | yes      |

Outputs
----------------------------------------------------------------------------------------------------

| Name          | Description                     |
|---------------|---------------------------------|
| target\_group | basicauth target group resource |


License
----------------------------------------------------------------------------------------------------

Apache 2 Licensed. See LICENSE for full details.
