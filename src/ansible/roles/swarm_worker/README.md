# Swarm Worker
This role configures a node to join an existing Docker Swarm cluster as a worker. It uses a provided worker join token and the IP address of an existing Swarm leader to securely join the cluster.

## Requirements
- Docker must be installed on the target node.
- The Swarm must already be initialized on a leader node.
- This node must be able to reach the Swarm leader over the network (default ports include 2377).
- Collections required: ansible.builtin, community.docker.

## Role Variables
| Variable       | Default                  | Description                                                                                                   |
| -------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------- |
| `worker_token` | `#{SWARM_WORKER_TOKEN}#` | The Swarm worker join token, typically retrieved from the leader node using `docker swarm join-token worker`. |
| `leader_ip`    | *Required*               | The IP address of the existing Swarm leader node to join.                                                     |

## Dependencies
This role assumes that a Swarm leader is already initialized using the `swarm.leader` role, and that this worker node has Docker installed (e.g., via the `swarm` role).

## Example Playbook
```yaml
- hosts: swarm_workers
  become: true
  vars:
    leader_ip: 192.168.1.100
    worker_token: "{{ lookup('env', 'SWARM_WORKER_TOKEN') }}"
  roles:
    - role: swarm.worker
```

## License
BSD

## Author Information
Created and maintained by Michiel Van Herreweghe [MichielVanHerreweghe](https://github.com/MichielVanHerreweghe). For issues or contributions, please visit the repository or contact via GitHub.