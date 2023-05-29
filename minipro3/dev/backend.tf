data "terraform_remote_state" "mini3_s3" {
    backend = "local"
    config = {
        path = "../backend/terraform.tfstate"
    }
}