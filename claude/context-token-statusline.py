#!/usr/bin/env python3
import json
import sys

try:
    payload = json.loads(sys.stdin.read())
    cw = payload.get('context_window', {})
    tokens = cw.get('total_input_tokens', 0) + cw.get('total_output_tokens', 0)
    max_tokens = cw.get('context_window_size', 200000)
    if max_tokens == 0:
        sys.exit(0)
except Exception:
    sys.exit(0)

pct = tokens / max_tokens * 100
display = f'{tokens / 1000:.1f}K'

if tokens < 60000:
    color = '\033[38;5;76m'
elif tokens < 100000:
    color = '\033[38;5;226m'
elif tokens < 140000:
    color = '\033[38;5;214m'
else:
    color = '\033[38;5;196m'

gray = '\033[38;5;245m'
reset = '\033[0m'

print(f'{color}{display}{reset} {gray}({pct:.1f}%){reset}', end='')
