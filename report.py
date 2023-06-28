#!/usr/bin/env python3

from pathlib import Path

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
for b in ["simple_loop", "nested_loop", "unpredictable", "fib_20", "longer_repetitive"]:
    svg = base / b / "report" / "violin.svg"
    svg_out = Path("report")
    filename = f"{b}_violin.svg"
    svg_out.mkdir(parents=True, exist_ok=True)
    with open(svg, "r") as f:
        content = f.read().replace(
            'xmlns="http://www.w3.org/2000/svg">',
            'xmlns="http://www.w3.org/2000/svg">\
            <rect x="0" y="0" width="960" height="204" fill="white"/>',
            1,
        )
    with open(svg_out / filename, "w") as f:
        f.write(content)
    graphs += f'<img src="{filename}" />\n'

index = template.replace("{{graphs}}", graphs)

with open(Path("report") / "index.html", "w") as f:
    f.write(index)

print("Open ./report/index.html")
