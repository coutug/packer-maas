packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "debian12" {
  boot_command           = ["<esc>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  boot_wait              = "3s"
  disk_image             = true
  disk_size              = "4G"
  memory                 = 2048
  cpus                   = 2
  headless               = true
  http_directory         = "http"
  iso_checksum           = "none"
  iso_url                = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.raw"
  qemuargs               = [["-serial", "stdio"]]
  ssh_handshake_attempts = 500
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_timeout            = "30m"
  shutdown_timeout       = "40m"
  shutdown_command       = "sudo -S shutdown -P now"
}

build {
  sources = ["source.qemu.debian12"]

  post-processor "shell-local" {
    inline = [
      "SOURCE=debian12",
      "OUTPUT=Debian12.tgz",
      "source ./scripts/fuse-nbd",
      "source ./scripts/fuse-tar-root"
    ]
    inline_shebang = "/bin/bash -e"
  }
}