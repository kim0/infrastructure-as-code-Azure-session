resource "azuread_application" "devops" {
  name                       = "kamal-webinar-demo-${var.cluster_name}"
  homepage                   = "https://cloud9ers.com/kamal"
  identifier_uris            = ["http://kamal-webinar-2019-02"]
  reply_urls                 = ["http://kamal-webinar-2019-02"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "devopsadmin" {
  application_id = "${azuread_application.devops.application_id}"
}

resource "random_string" "sppasswd" {
  length = 32
}

resource "azuread_service_principal_password" "devopspassword" {
  service_principal_id = "${azuread_service_principal.devopsadmin.id}"
  value                = "${random_string.sppasswd.result}"
  end_date             = "2019-05-01T01:02:03Z"
  
  # wait 30s for server replication before attempting role assignment creation
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
