# cdtool

A simple Windows batch script for quickly navigating to frequently-used project directories using custom aliases.

## Overview

`cdtool` lets you jump to your project folders instantly by typing short, memorable aliases instead of long paths. No more typing `cd C:\long\path\to\my\project` repeatedly!

## Installation

1. **Download the script**: Save the `cdtool.bat` file to a directory that's in your system PATH
   - Recommended location: `C:\Windows\System32` (requires admin rights)
   - Alternative: Create a custom folder like `C:\tools` and add it to your PATH

2. **Add to PATH** (if using custom location):
   - Right-click "This PC" → Properties → Advanced System Settings
   - Click "Environment Variables"
   - Under "System variables", find and edit "Path"
   - Add your script directory (e.g., `C:\tools`)
   - Click OK to save

3. **Verify installation**: Open a new Command Prompt and type:
   ```cmd
   cdtool
   ```
   You should see the usage instructions.

## Usage

### View available aliases
```cmd
cdtool
```

### Navigate to a project
```cmd
cdtool truzy
```

This will switch your current directory to the configured path and display the new location.

## Configuration

### Adding new aliases

Edit the `cdtool.bat` file and add a new condition block for your alias:

```batch
if /i "%1"=="myproject" (
    cd /d "C:\path\to\your\project"
    echo Switched to: %CD%
    goto :eof
)
```

**Important**: 
- Place new aliases before the "Unknown alias" error block
- Update the help text in the "Available aliases" section
- Use `/d` flag with `cd` to change drives if needed

### Example: Adding multiple aliases

```batch
if /i "%1"=="frontend" (
    cd /d "C:\projects\myapp\frontend"
    echo Switched to: %CD%
    goto :eof
)

if /i "%1"=="backend" (
    cd /d "C:\projects\myapp\backend"
    echo Switched to: %CD%
    goto :eof
)

if /i "%1"=="docs" (
    cd /d "D:\documentation"
    echo Switched to: %CD%
    goto :eof
)
```

## Current Aliases

| Alias | Path | Description |
|-------|------|-------------|
| `truzy` | `C:\piyush-work\personal\truzy-tracking\api` | Truzy tracking API project |

## Tips

- **Use short, memorable names**: `truzy`, `api`, `web`, etc.
- **Case-insensitive**: `cdtool TRUZY` works the same as `cdtool truzy`
- **Combine with other commands**: After switching directories, you can immediately run other commands:
  ```cmd
  cdtool truzy && npm start
  ```
- **Create project-specific workflows**: Make aliases for different parts of monorepos or related projects

## Troubleshooting

**"cdtool is not recognized as an internal or external command"**
- The script is not in your PATH. Double-check the installation steps.

**Script runs but doesn't change directory**
- Make sure you're running the script directly with `cdtool`, not `call cdtool`
- Verify the path in the script exists and is accessible

**Changes to PATH not taking effect**
- Close and reopen your Command Prompt after modifying PATH
- Restart Windows Explorer or log out/in if needed

## License

Free to use and modify for personal or commercial projects.

## Contributing

Feel free to fork and customize for your needs! Suggestions for improvements:
- Add support for relative paths
- Create a config file instead of hardcoding paths
- Add auto-completion support
- Port to PowerShell for cross-platform support

---

**Author**: Piyush  
**Version**: 1.0