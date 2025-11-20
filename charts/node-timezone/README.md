# Node Timezone Chart

This Helm chart configures the system timezone for OpenShift worker and master nodes using MachineConfig resources.

## Installation

```bash
helm install node-timezone ./charts/node-timezone
```

## Configuration

### Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `timezone.value` | Timezone to configure (e.g., "America/Santiago") | `"America/Santiago"` |
| `machineConfig.enabled` | Enable timezone configuration | `true` |
| `machineConfig.worker.enabled` | Configure timezone on worker nodes | `true` |
| `machineConfig.master.enabled` | Configure timezone on master nodes | `true` |

### Examples

#### Set specific timezone
```yaml
timezone:
  value: "America/New_York"
```

#### Configure only worker nodes
```yaml
machineConfig:
  master:
    enabled: false
```

#### Custom labels and annotations
```yaml
machineConfig:
  worker:
    labels:
      company: "telefonica"
    annotations:
      description: "Custom timezone configuration"
```

## Notes

- This chart creates MachineConfig resources that will cause node reboots
- Changes are applied automatically by the Machine Config Operator
- Verify timezone after nodes restart: `timedatectl status`