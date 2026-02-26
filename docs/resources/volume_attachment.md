---
page_title: "verda_volume_attachment Resource - Verda Provider"
subcategory: "Storage"
description: |-
  Attaches a Verda volume to an instance and provides mount commands.
---

# verda_volume_attachment (Resource)

Attaches an existing `verda_volume` to a `verda_instance` and exposes the mount commands needed to make the volume available inside the instance. Destroying this resource detaches the volume without deleting it.

The volume and instance can be created in parallel — Terraform resolves the dependency automatically because this resource references both.

-> **Shared filesystems:** This resource is primarily intended for shared filesystem volumes (`type = "NVMe_Shared"`), where the mount command is only known after attachment. For standard NVMe volumes, it is simpler to use the `volumes` or `existing_volumes` attributes on [`verda_instance`](instance) directly.

## Example Usage

```terraform
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
```

After `terraform apply`, run the output commands on the instance to mount the volume:

```bash
# 1. Create the mount directory
$(terraform output -raw create_directory_command)

# 2. Mount the volume
$(terraform output -raw mount_command)

# 3. Optionally persist across reboots
$(terraform output -raw filesystem_to_fstab_command)
```

-> **Note:** The volume and instance must be in the same location.

## Schema

### Required

- `instance_id` (String) ID of the instance to attach the volume to.
- `volume_id` (String) ID of the volume to attach.

### Read-Only

- `create_directory_command` (String) Shell command to create the mount directory on the instance.
- `filesystem_to_fstab_command` (String) Shell command to add the volume to `/etc/fstab` for mounts that persist across reboots.
- `mount_command` (String) Shell command to mount the volume on the instance.

## Import

Existing attachments can be imported using `{volume_id}/{instance_id}`:

```shell
terraform import verda_volume_attachment.example <volume-id>/<instance-id>
```
