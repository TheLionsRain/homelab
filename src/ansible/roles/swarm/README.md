# Swarm
This role is used for preparing a machine to be used for Docker Swarm. It installs Docker and its dependencies, sets up the appropriate repository and GPG keys, and ensures the user can run Docker without sudo.

## Requirements
- The target system should be a Debian-based distribution (e.g., Ubuntu).
- Python must be installed on the managed host.
- This role assumes internet access to download Docker packages and keys.
- Ansible community.general and ansible.builtin collections should be available.
- The boto package is not required, but if you're deploying on cloud instances (e.g., EC2), ensure related modules and credentials are set up outside this role.

## Role Variables
| Variable               | Default/Required       | Description                                                                                                 |
| ---------------------- | ---------------------- | ----------------------------------------------------------------------------------------------------------- |
| `docker_architecture`  | Required               | The system architecture, usually `amd64` or `arm64`, used in the Docker apt repository configuration.       |
| `ansible_user`         | Automatically provided | The user who will be added to the Docker group for non-root Docker usage.                                   |
| `ansible_lsb.codename` | Automatically provided | Used to dynamically set the appropriate Ubuntu codename (e.g., `focal`, `jammy`) for the Docker apt source. |

## Dependencies

None explicitly, but ensure your environment satisfies the requirements mentioned above. If you're using this in combination with other roles (e.g., security hardening, firewall), ensure Docker ports (e.g., `2377`, `7946`, `4789`) are open.

## Example Playbook
```yaml
- hosts: docker_nodes
  become: true
  vars:
    docker_architecture: amd64
  roles:
    - role: swarms
```

## License
BSD

## Author Information
Created and maintained by Michiel Van Herreweghe [MichielVanHerreweghe](https://github.com/MichielVanHerreweghe). For issues or contributions, please visit the repository or contact via GitHub.