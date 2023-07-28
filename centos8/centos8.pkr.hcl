packer {
  required_version = ">= 1.7.0"
  required_plugins {
    qemu = {
      version = "~> 1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "filename" {
  type        = string
  default     = "centos8.tar.gz"
  description = "The filename of the tarball to produce"
}

variable "centos8_iso_url" {
  type    = string
  default = "https://mirror.mtl2.ca.leaseweb.net/centos/8-stream/isos/x86_64/CentOS-Stream-8-20230710.0-x86_64-boot.iso"
}

source "qemu" "centos8" {
  boot_command     = ["<up><tab> ", "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos8.ks ", "console=ttyS0 inst.cmdline", "<enter>"]
  boot_wait        = "3s"
  communicator     = "none"
  disk_size        = "4G"
  headless         = true
  http_directory   = "http"
  iso_checksum     = "none"
  iso_url          = var.centos8_iso_url
  memory           = 2048
  qemuargs         = [["-serial", "stdio"]]
  shutdown_timeout = "1h"
}

build {
  sources = ["source.qemu.centos8"]

  post-processor "shell-local" {
    inline = [
      "SOURCE=centos8",
      "OUTPUT=${var.filename}",
      "source ../scripts/fuse-nbd",
      "source ../scripts/fuse-tar-root"
    ]
    inline_shebang = "/bin/bash -e"
  }
}
