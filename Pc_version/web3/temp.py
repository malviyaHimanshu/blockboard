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
    new_clipboard_data = pyperclip.paste()
    result = subprocess.run(["node", "main.js"],capture_output=True, text=True)
    print("prev= ",clipboard_data," present= ",new_clipboard_data," result: ",result.stdout.split('\n')[0])
   # when prev!= present
    if new_clipboard_data != clipboard_data: 
        print("updating blockchain")
        clipboard_data = new_clipboard_data
        text1 = clipboard_data
        result = subprocess.run(["node", "main.js", f"--text={text1}".format(text1=clipboard_data)],
                                capture_output=True, text=True)
        while True:
            result = subprocess.run(["node", "main.js"],capture_output=True, text=True)
            print(result)
            print("Loading...")
            if(result.stdout.split("\n")[0] == new_clipboard_data):
                 break
    #when (prev==present)!= result
    elif( clipboard_data == new_clipboard_data and clipboard_data != result.stdout.split('\n')[0]):
            pyperclip.copy(result.stdout.split('\n')[0])
            clipboard_data=result.stdout
            print("updated clipboard to ",result.stdout)
