#!/usr/bin/python3
import datetime
import json
from pathlib import Path
import shutil
import sys

target = Path('/etc/firefox/policies/policies.json')
incoming = json.loads(Path(sys.argv[1]).read_text())
existing = json.loads(target.read_text()) if target.exists() else {}
def merge(old, new):
    for key, value in new.items():
        if isinstance(value, dict) and isinstance(old.get(key), dict):
            merge(old[key], value)
        else:
            old[key] = value
merge(existing, incoming)
content = json.dumps(existing, indent=2) + '\n'
if target.exists() and target.read_text() == content:
    sys.exit(0)
if target.exists():
    backup = target.with_name('policies.json.backup-' + datetime.datetime.now().strftime('%Y%m%d-%H%M%S'))
    shutil.copy2(target, backup)
target.parent.mkdir(parents=True, exist_ok=True)
target.write_text(content)
target.chmod(0o644)
