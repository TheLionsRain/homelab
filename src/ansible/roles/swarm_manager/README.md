# Swarm Manager
This role configures a node to join an existing Docker Swarm cluster as a manager. It uses a provided manager token and the IP address of an existing Swarm leader to securely join the cluster.

## Requirements
- Docker must be installed on the target node.
- The Swarm must already be initialized on a leader node.
- This node must be able to reach the Swarm leader over the network (default ports include 2377).
- Collections required: ansible.builtin, community.docker.

## Role Variables
| Variable        | Default                   | Description                                                                                                     |
| --------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `manager_token` | `#{SWARM_MANAGER_TOKEN}#` | The Swarm manager join token, typically retrieved from the leader node using `docker swarm join-token manager`. |
| `leader_ip`     | *Required*                | The IP address of the existing Swarm leader node to join.                                                       |

## Dependencies
This role assumes that a Swarm leader is already initialized using the `swarm.leader` role, and that this manager node has Docker installed (e.g., via the `swarm` role).

## Example Playbook
```yaml
- hosts: swarm_managers
  become: true
  vars:
    leader_ip: 192.168.1.100
    manager_token: "{{ lookup('env', 'SWARM_MANAGER_TOKEN') }}"
  roles:
    - role: swarm.manager
```

## License
BSD

## Author Information
Created and maintained by Michiel Van Herreweghe [MichielVanHerreweghe](https://github.com/MichielVanHerreweghe). For issues or contributions, please visit the repository or contact via GitHub.