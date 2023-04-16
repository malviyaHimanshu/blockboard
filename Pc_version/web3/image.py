import base64
import os

import win32clipboard
from PIL import ImageGrab, Image
import pyperclip
import cv2
import numpy as np





def getImage():
    img = ImageGrab.grabclipboard()
    paste = pyperclip.paste()
    if paste == "":
        # print(paste)
        # print(img)
        # print("path: ", os.path.abspath("clipboard_image.png"))
        # Load the image
        import requests
        response = requests.post(
            'https://api.remove.bg/v1.0/removebg',
            files={'image_file': open(str(img[0]) , 'rb')},
            data={'size': 'auto'},
            headers={'X-Api-Key': '1DCGa2aPDJzu7n55wKdXKC7L'},
        )
        if response.status_code == requests.codes.ok:
            with open('no-bg.png', 'wb') as out:
                out.write(response.content)
        else:
            print("Error:", response.status_code, response.text)
        path = os.path.abspath('no-bg.png')
        pyperclip.copy(path)
        print("updated to",pyperclip.paste())
        return path

# getImage()
getImage()