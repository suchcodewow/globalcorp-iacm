variable "uniqueIdentifier" {
  type = string
  default = "default"
}
variable "googleRegion" {
  type = string
  default = "requiredbutmissing"
}
variable "googleProject" {
    type = string
    default="requiredbutmissing"
}
variable "accountId" {
    type = string
    default="requiredbutmissing"
}
variable "delegateToken" {
    type = string
    default="requiredbutmissing"
}
variable "delegateManagerUrl" {
    type = string
    default="https://app.harness.io/gratis"
}
variable "delegateLogUrl" {
    type = string
    default = "https://app.harness.io/gratis/log-service/"
}
variable "googleServiceAccount" {
  type = string
  default = ""
}
variable "proxyHost" {
  type = string
  default = ""
}
variable "proxyPort" {
  type = string
  default = ""
}

resource "google_cloud_run_v2_service" "default" {
  name     = "harness-delegate-${var.uniqueIdentifier}"
  location = var.googleRegion
  project = var.googleProject

  deletion_protection = false # set to "true" in production
    # Send-Update -t 1 -c "Deploying Delegate" -r "gcloud run deploy $delegateName --memory=2Gi --port=3460 --image=harness/delegate:24.09.83909 --no-allow-unauthenticated --min-instances=1 --max-instances=1 --no-cpu-throttling --set-env-vars=JAVA_OPTS=$($config.Harness_JAVA_OPTS),ACCOUNT_ID=$($config.Harness_ACCOUNT_ID),DELEGATE_NAME=$delegateName,NEXT_GEN=true,DEPLOY_MODE=KUBERNETES,DELEGATE_TYPE=KUBERNETES,CLIENT_TOOLS_DOWNLOAD_DISABLED=true,DYNAMIC_REQUEST_HANDLING=false,DELEGATE_TOKEN=$($config.Harness_DELEGATE_TOKEN),LOG_STREAMING_SERVICE_URL=$($config.Harness_LOG_STREAMING_SERVICE_URL),MANAGER_HOST_AND_PORT=$($config.Harness_MANAGER_HOST_AND_PORT),INIT_SCRIPT= "

  template {
    service_account = var.googleServiceAccount
    containers {
      image = "harness/delegate:24.09.83909"
      startup_probe {
        initial_delay_seconds = 120
        timeout_seconds = 240
        period_seconds = 3
        failure_threshold = 10
        tcp_socket {
          port = 3460
        }
      }
      env {
        name  = "JAVA_OPTS"
        value = "-Xms64M"
      }
      env {
        name = "ACCOUNT_ID"
        value = var.accountId
      }
      env {
        name = "DELEGATE_NAME"
        value = "harness-delegate-${var.uniqueIdentifier}"
      }
      env {
        name = "NEXT_GEN"
        value = "true"
      }
      env {
        name = "DEPLOY_MODE"
        value = "KUBERNETES"
      }
      env {
        name = "DELEGATE_TYPE"
        value = "KUBERNETES"
      }
      env {
        name = "CLIENT_TOOLS_DOWNLOAD_DISABLED"
        value = "true"
      }
      env {
        name = "DYNAMIC_REQUEST_HANDLING"
        value = "false"
      }
      env {
        name = "DELEGATE_TOKEN"
        value = var.delegateToken
      }
      env {
        name = "ACCOUNT_ID"
        value = var.accountId
      }
      env {
        name = "MANAGER_HOST_AND_PORT"
        value = var.delegateManagerUrl
      }
      env {
        name = "LOG_STREAMING_SERVICE_URL"
        value = var.delegateLogUrl
      }
      env {
        name = "INIT_SCRIPT"
        value = <<EOT
            curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
            tar -xf google-cloud-cli-linux-x86_64.tar.gz
            ./google-cloud-sdk/install.sh
            ./google-cloud-sdk/bin/gcloud init
            EOT
      }
      env {
        name = "PROXY_HOST"
        value = var.proxyHost
      }
      env {
        name = "PROXY_PORT"
        value = var.proxyPort
      }
      resources {
        # If true, garbage-collect CPU when once a request finishes
        cpu_idle = false
        limits = {
            cpu = "1"
            memory = "4Gi"
        }

        startup_cpu_boost = true
      }
    }
    scaling {
        min_instance_count = 1
        max_instance_count = 1
      }
  }
}