resource "verda_ssh_key" "main" {
  name       = "my-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "verda_volume" "data" {
  name     = "training-data"
  size     = 500
  type     = "NVMe_Shared"
  location = "FIN-01"
}

resource "verda_instance" "trainer" {
  instance_type = "1B200.30V"
  image         = "ubuntu-24.04-cuda-12.8-open-docker"
  hostname      = "trainer"
  description   = "ML training instance"
  location      = "FIN-01"

  ssh_key_ids = [verda_ssh_key.main.id]
}

resource "verda_volume_attachment" "data" {
  volume_id   = verda_volume.data.id
  instance_id = verda_instance.trainer.id
}

output "mount_command" {
  value = verda_volume_attachment.data.mount_command
}

output "create_directory_command" {
  value = verda_volume_attachment.data.create_directory_command
}

output "filesystem_to_fstab_command" {
  value = verda_volume_attachment.data.filesystem_to_fstab_command
}
