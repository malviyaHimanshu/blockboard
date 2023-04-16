import pyperclip
import os
 
pastee = pyperclip.paste()
if pastee == "":
    print("True")
else:
    print("False")
print(type(pastee))