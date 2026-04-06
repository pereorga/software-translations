filename = "sumatra.po"

with open(filename, "r") as file:
    lines = file.readlines()

new_lines = []
skip = False

for idx, line in enumerate(lines):
    if line.startswith("msgid "):
        # If the next line also starts with "msgid " (or there is no next line), skip the current line
        if idx + 1 >= len(lines) or lines[idx + 1].startswith("msgid "):
            skip = True
            continue
        # Else, append the current line
        elif skip:
            skip = False
            new_lines.append(line)
            continue
    new_lines.append(line)

# Write back to the file
with open(filename, "w") as file:
    file.writelines(new_lines)
