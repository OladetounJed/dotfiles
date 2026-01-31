# Work Context

This directory contains work-specific configuration.

## Setup

1. Create a private repo: `work-context` (or keep locally)
2. Copy these example files and customize for your context
3. Place at: `~/dev/work-context/`

## Structure

```
~/dev/work-context/
├── yolo.json          # Yolo/pickem88 configuration
├── vericraft.json     # Vericraft configuration
└── current            # Symlink to active context
```

## Usage in Agents

Reference in your CLAUDE.md:
```markdown
## Work Context

For team/product-specific information, reference:
- `~/dev/work-context/yolo.json` - Yolo team config
- `~/dev/work-context/vericraft.json` - Vericraft config
```

## Security

- Use environment variables for secrets
