# cdtool

A simple Windows batch script for quickly navigating to project directories using aliases. Aliases are stored in a config file and managed with commands—no editing the script.

## Installation

1. Save `cdtool.bat` to a folder that's in your PATH (e.g. `C:\tools` or `C:\Windows\System32`).
2. Add that folder to your environment PATH (Environment Variables → Path).
3. Open a new Command Prompt and run `cdtool` to verify.

The script creates `cdtool_aliases.cfg` next to itself if the file doesn't exist.

## Usage

- **View aliases:** `cdtool` or `cdtool list`
- **Go to alias:** `cdtool <alias>` (e.g. `cdtool truzy`)
- **Add alias:** `cdtool set-new <alias> <path>` or `cdtool set-new alias=path`
- **Remove alias:** `cdtool remove <alias>`
- **Change path:** `cdtool update <alias> <path>`

## Configuration

Aliases are stored in `cdtool_aliases.cfg` (same folder as `cdtool.bat`), one line per alias: `alias=path`. Use the commands above to add, remove, or update aliases.

## Current aliases

Run `cdtool list` (or `cdtool`) to see your aliases.

## Tips

- Use short, memorable names. Aliases are case-insensitive.
- Chain commands: `cdtool truzy && npm start`

## Troubleshooting

- **"cdtool is not recognized"** — Script folder is not in your PATH.
- **Directory doesn't change** — Run `cdtool` directly (not `call cdtool`). Ensure the path exists.
- **PATH changes not applied** — Close and reopen Command Prompt (or log out/in).

## License

Free to use and modify for personal or commercial projects.

## Contributing

Fork and customize. Ideas: relative paths, auto-completion, PowerShell port.

---

**Author**: Piyush  
**Version**: 2.0
