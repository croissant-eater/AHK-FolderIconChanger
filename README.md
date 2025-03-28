# AHK Folder Icon Changer

## Description
This AutoHotkey script automates the process of customizing folder icons in Windows 10 and 11. It iterates through all subdirectories in the current Explorer window and opens each folder's properties dialog to customize the folder icon. Using UI Automation via the UIA_Interface library, the script navigates the properties window to select and apply a new icon automatically.

The script is designed to streamline repetitive tasks, making it easier to update folder icons across multiple directories with just a hotkey press.

## Installation
- **Requirement:** AutoHotkey v1.1.37  
  [Download AutoHotkey v1.1.37]([https://www.autohotkey.com/](https://www.autohotkey.com/download/1.1/AutoHotkey_1.1.37.02_setup.exe))  
- Clone this repository or download and extract the ZIP file.  
- Ensure that the `Lib` folder containing `UIA_Interface.ahk` is in the same directory as the script.

## Usage
1. **Run the Script:**  
   Double-click the main script file (e.g., `main.ahk`) to start the script.

2. **Trigger the Automation:**  
   Open a Windows Explorer window and navigate to the desired folder.  
   Press `Alt + F` to start the folder customization process. The script will:
   - Retrieve the current Explorer path.
   - Loop through each subdirectory.
   - Open each folder’s properties dialog.
   - Navigate to the Customize tab.
   - Open the Change Icon dialog and automatically select the first icon in the list.

3. **Exit the Script:**  
   Press `Shift + Esc` to exit the script.

## Demonstration
![Usage Demo](rsc/ChangeAllDemo.gif)
