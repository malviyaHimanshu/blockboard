import subprocess
import pyperclip

def execute_command(command):
    """
    Execute a command in the terminal and return the output.

    Args:
        command (str): The command to execute.

    Returns:
        str: The output of the command.
    """
    process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    output, error = process.communicate()
    if error:
        return error.decode('utf-8')
    return output.decode('utf-8')

clipboard_data = pyperclip.paste()

print(clipboard_data)

if clipboard_data:
    pyperclip.copy(execute_command("node /Users/parzival979/Documents/GitHub/blockboard/Pc_version/web3/main.js --text '{text}'".format(text = clipboard_data)))