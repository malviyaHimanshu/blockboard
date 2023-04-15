import pyperclip
import win32clipboard
import time
import subprocess
import os

# Initialize the clipboard data variable to an empty string
clipboard_data = pyperclip.paste()
# Loop forever
while True:
    # Check if the clipboard data has changed
    win32clipboard.OpenClipboard()
    new_clipboard_data = win32clipboard.GetClipboardData()
    win32clipboard.CloseClipboard()

    if new_clipboard_data != clipboard_data:
        clipboard_data = new_clipboard_data
        # print(clipboard_data)
        # Execute the "node main.js" command and capture output
        text1 = clipboard_data
        result = subprocess.run(["node", "main.js", f"--text={text1}".format(text1=clipboard_data)],
                                capture_output=True, text=True)
        # result = subprocess.run(["node", "main.js"], capture_output=True, text=True)
        print("waiting for node to complete")
        print(result.stdout)
        print("done waiting for node to complete")

    # Open the file and read its contents
    with open("clipboard_content.txt", "r") as file:
        # Assign the first line of the file to the clipboard_data variable
        block = file.readline().strip()
    # Print the contents of the clipboard_data variable to verify the script worked
    print(block)

    if block != clipboard_data:
        print("copying the block data to clipboard")
        result = subprocess.run(["node", "main.js"],capture_output=True, text=True)
        print(result.stdout)
        print("copying the block data to clipboard")
        pyperclip.copy(result.stdout)
        # print(pyperclip.paste())
        # print(block)
    # Copy the contents of the clipboard_data variable to the clipboard
    # if pyperclip.paste() != clipboard_data:
    #     pyperclip.copy(result.stdout)
    # Wait for a short period of time before checking the clipboard again
    time.sleep(3)
