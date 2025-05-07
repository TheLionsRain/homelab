# Swarm Leader
This role initializes a Docker Swarm on a leader node. It ensures Docker Swarm is active and, if not, initiates it using the host's default IPv4 address. The role is typically used as the first step in setting up a Docker Swarm cluster, before adding worker nodes.

## Requirements
- Docker must be installed and accessible on the target system (e.g., via the swarm role).
- The target system must have internet access and a valid IP address assigned to the default interface.
- This role assumes you're using Ansible with elevated privileges (become: true).
- Ansible ansible.builtin collection must be available.

## Role Variables
| Variable          | Default              | Description                                                                        |
| ----------------- | -------------------- | ---------------------------------------------------------------------------------- |
| `services_folder` | `/opt/docker/stacks` | Directory on the leader node intended to store or mount service stack definitions. |

## Dependencies
This role assumes Docker is already installed. You should run this role after the `swarm` role to ensure the system is Docker-ready.

## Example Playbook
```yaml
- hosts: swarm_leader
  become: true
  roles:
    - role: swarm.leader
```

## License
BSD

## Author Information
Created and maintained by Michiel Van Herreweghe MichielVanHerreweghe. For issues or contributions, please visit the repository or contact via GitHub.