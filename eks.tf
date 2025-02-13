module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = local.cluster_name
  cluster_version = "1.31"

 
  cluster_endpoint_public_access = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
     ami_type = "AL2_x86_64"
   }



  eks_managed_node_groups = {
     one = {
        name = "node-group-1"
        instance_types = ["t3.small"]
        min_size = 1
        max_size = 3
        desired_size =2
        security_group_ids = [aws_security_group.eks_node_group_sg.id]
        key_name      = var.my-key
        
     }
     two = {
        name = "node-group-2"
        instance_types = ["t3.small"]
        min_size = 1
        max_size = 2
        desired_size = 1
        security_group_ids = [aws_security_group.eks_node_group_sg.id]
        key_name      = var.my-key
        
     }
     
  }
  
}



