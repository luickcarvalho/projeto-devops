locals {
  ### DYNAMIC VARS ###
  vpc_id = data.aws_vpc.vpc.id
  
  subnets_prd = [data.aws_subnet.subnet-a.id, data.aws_subnet.subnet-b.id, data.aws_subnet.subnet-c.id, data.aws_subnet.subnet-d.id]

}