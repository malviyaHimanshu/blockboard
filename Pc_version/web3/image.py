import base64
import os

import win32clipboard
from PIL import ImageGrab, Image
import pyperclip


def getImage():
    img = ImageGrab.grabclipboard()
    if img is not None:
        img.save("clipboard_image.png")
        # print("path: ", os.path.abspath("clipboard_image.png"))
        pyperclip.copy(os.path.abspath("clipboard_image.png"))
    else:
        print("No image in clipboard")

# getImage()

