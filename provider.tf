provider "aws" {
  shared_credentials_file = "/home/jr/.aws/credentials"
  profile                 = "pessoal"
  
  # O Cognito só está disponível na região de N. Virginia (US East)
  region = "us-east-1"
}
