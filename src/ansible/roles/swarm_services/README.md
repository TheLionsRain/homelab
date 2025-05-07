# Swarm Services
This role is responsible for deploying custom Docker Swarm services using Docker Stack. It sets up a target directory for service definitions, renders docker-compose templates, and deploys them to the Swarm manager node.

## Requirements
- Docker and Docker Swarm must be installed and initialized on the target system.
- This role assumes you have defined service-specific Compose templates and relevant environment variables.
- Collections required: ansible.builtin, community.docker.
- Internet access is typically required for pulling container images.

## Role Variables
| Variable          | Default              | Description                                                                              |
| ----------------- | -------------------- | ---------------------------------------------------------------------------------------- |
| `services_folder` | `/opt/docker/stacks` | The base directory where service definitions and `docker-compose` files will be created. |
| `access_token`    | `#{ACCESS_TOKEN}#`   | Optional variable to inject secrets (e.g., API tokens) into service templates.           |

## Dependencies
This role assumes that the Docker Swarm environment is already initialized. You should run this after the `swarm` and `swarm.leader` roles.

## Example Playbook
```yaml
- hosts: swarm_leader
  become: true
  vars:
    access_token: "{{ lookup('env', 'MY_SERVICE_ACCESS_TOKEN') }}"
  roles:
    - role: swarm.services
```

## Templates
### Github Actions Private Runner
```jinja2
services:
  my-service:
    image: myorg/myservice:latest
    deploy:
      replicas: 2
    environment:
      - ENV_VAR1=value1
      - ACCESS_TOKEN={{ access_token }}
    volumes:
      - /data:/data
```

## License
BSD

## Author Information
Created and maintained by Michiel Van Herreweghe MichielVanHerreweghe. For issues or contributions, please visit the repository or contact via GitHub.