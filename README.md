# agent-skill-collections

A curated collection of agent skills, installable via `npx skills add` or `hermes skills tap add`.

## Skills

| Directory | Description | Upstream |
|-----------|-------------|----------|
| `skillopt` | Skill optimization methodology — run controlled optimization cycles on any SKILL.md using a kanban board system. | [magnus919/hermes-SkillOpt](https://github.com/magnus919/hermes-SkillOpt) |
| `historical-bayesian-html-briefing` | Generate historically-grounded Bayesian HTML briefings with forecast ledgers, flow charts, and evidence tracking. | [H-Ali13381/historical-bayesian-html-briefing](https://github.com/H-Ali13381/historical-bayesian-html-briefing) |

## Install

### Via Vercel skills CLI

```bash
# Install all skills
npx skills add latipun7/agent-skill-collections --all -g

# Or install individual skills
npx skills add latipun7/agent-skill-collections --skill skillopt -g
npx skills add latipun7/agent-skill-collections --skill historical-bayesian-html-briefing -g
```

### Via Hermes

```bash
# Add as a skill tap
hermes skills tap add latipun7/agent-skill-collections

# Search for skills
hermes skills search skillopt

# Install
hermes skills install latipun7/agent-skill-collections/skillopt
hermes skills install latipun7/agent-skill-collections/historical-bayesian-html-briefing
```

## Updating

These skills are snapshots of their upstream repos. To pull latest changes:

```bash
./scripts/sync-upstream.sh
git add -A
git commit -m "sync: pull upstream updates"
git push
```

Or do a dry run first:

```bash
./scripts/sync-upstream.sh --dry-run
```

## Structure

```
agent-skill-collections/
├── skills/
│   ├── skillopt/               ← hermes-SkillOpt
│   │   ├── SKILL.md
│   │   ├── references/
│   │   ├── scripts/
│   │   └── templates/
│   └── historical-bayesian-html-briefing/
│       ├── SKILL.md
│       ├── references/
│       ├── scripts/
│       ├── templates/
│       └── examples/
├── scripts/
│   └── sync-upstream.sh        ← pull upstream changes
└── README.md
```
