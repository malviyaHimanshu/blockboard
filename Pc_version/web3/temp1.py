import pyperclip
import time
import subprocess
import os

# Initialize the clipboard data variable to an empty string
clipboard_data = pyperclip.paste()
# Loop forever
while True:
    # Check if the clipboard data has changed
    new_clipboard_data = pyperclip.paste()
    

    result = subprocess.run(["node", "main.js"], capture_output=True, text=True)
    if(result==""):
                result = subprocess.run(["node", "main.js", f"--text 'd' "],
                                capture_output=True, text=True)
    print("prev= ", clipboard_data, " present= ", new_clipboard_data, " result: ", result.stdout.split('\n')[0])
    # when prev!= present
    if new_clipboard_data != clipboard_data:
        print("pyperclip paste gave : ",pyperclip.paste())
        new_clipboard_data = pyperclip.paste()
        pastee = pyperclip.paste()
        if pastee == "":
            print("image found")
            import image
            no_background_img=image.getImage()
            new_clipboard_data = str(no_background_img)
            print("updating blockchain")
            prompt_=["node", "put-files.js", f"{new_clipboard_data}".format(text1=clipboard_data)]
            print(prompt_)
            result = subprocess.run(prompt_,
                                    capture_output=True, text=True)
            print("result:",result)
            break
            while True:
                result = subprocess.run(["node", "main.js"], capture_output=True, text=True,check=True)
                print("stdout:",result.stdout)
                print("Loading...")
                if (result.stdout.split("\n")[0] == "image123"):
                    break
        
        else:
            print("updating blockchain")
            clipboard_data = new_clipboard_data
            text1 = clipboard_data
            result = subprocess.run(["node", "main.js", f"--text={text1}".format(text1=clipboard_data)],
                                    capture_output=True, text=True)
            print("text: ",text1,"result:",result)
            while True:
                result = subprocess.run(["node", "main.js"], capture_output=True, text=True)
                print("stdout:",result.stdout)
                # if(result==""):
                #     result = subprocess.run(["node", "main.js", f"--text 'd' "],
                #                     capture_output=True, text=True)
                print("Loading...")
                if (result.stdout.split("\n")[0] == new_clipboard_data):
                    break
    # when (prev==present)!= result
    elif (clipboard_data == new_clipboard_data and clipboard_data != result.stdout.split('\n')[0]):
        pyperclip.copy(result.stdout.split('\n')[0])
        clipboard_data = result.stdout
        print("updated clipboard to ", result.stdout)
