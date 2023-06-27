#!/usr/bin/env python3

from pathlib import Path
from subprocess import check_output

template = """<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" context="text/html; charset=utf-8">
    <title>Benchmark Report</title>
    </head>
    <body>
        {{graphs}}
    </body>
</html>
"""

graphs = ""
base = Path("target/criterion")
for b in ["simple_loop", "nested_loop", "unpredictable"]:
    svg = base / b / "report" / "violin.svg"
    svg_out = Path("report")
    filename = f"{b}_violin.svg"
    svg_out.mkdir(parents=True, exist_ok=True)
    with open(svg, "r") as f:
        content = f.read().replace('fill="none"/>', 'fill="white"/>', 1)
    with open(svg_out / filename, "w") as f:
        f.write(content)
    graphs += f'<img src="{filename}" />\n'

index = template.replace("{{graphs}}", graphs)

with open(Path("report") / "index.html", "w") as f:
    f.write(index)

check_output(["open", "report/index.html"])
