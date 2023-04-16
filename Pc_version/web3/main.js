import process from 'process'
import minimist from 'minimist'
import fs from 'fs'
import open from 'open';
import { spawn } from 'child_process'
import fetch from 'node-fetch';
import { Headers } from 'node-fetch';
const TOKEN='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDc2M2U4ZkMzNTFkNGQ0MUE4NWNFYUUyM2REMUQzNmFFODZDZEVlOGUiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2ODE1NDEyMjE5NjEsIm5hbWUiOiJibG9ja2JvYXJkIn0.Mpwk3LiVhQrztvHeYTy3dKyVscMU_AbpwbZ47fLNKX4'
async function getClipboardContent(latestCID) {
  console.log("latest cid is : ",latestCID)
  try {
    const clipboardUrl = `https://${latestCID}.ipfs.dweb.link/clipboard_content.txt`;
    const noBgUrl = `https://${latestCID}.ipfs.dweb.link/no-bg.png`;

    // Fetch clipboard content
    const clipboardResponse = await fetch(clipboardUrl);
    const clipboardData = await clipboardResponse.text();
    if(clipboardData.split(" ")[0]=="failed"){
      open(noBgUrl);
      console.log("image123")
    }
    else{
      console.log(clipboardData)
    }
    return clipboardData;
  } catch (error) {
    console.error('Error fetching clipboard content:', error);
    return null;
  }
}



async function getLatestTextFile(token) {
  const headers = new Headers()
  headers.append('Authorization', `Bearer ${token}`)
  headers.append('accept', 'application/json')

  const response = await fetch('https://api.web3.storage/user/uploads', {
    method: 'GET',
    headers: headers
  })
  const json = await response.json()
  
  console.log(json)
  const latestFile = json[0]

  const latestCID=latestFile.cid
  getClipboardContent(latestCID)


}





function writeToClipboard(text) {
  const fileName = 'clipboard_content.txt'

  // Check if the file already exists
  if (fs.existsSync(fileName)) {
    console.log(`File ${fileName} already exists`)
    fs.writeFileSync(fileName, text)
    console.log(`File ${fileName} updated with contents: ${text}`)

  } else {
    // Create the file if it doesn't exist
    fs.writeFileSync(fileName, text)
    console.log(`File ${fileName} created with contents: ${text}`)
  }
}


async function main() {
  const args = minimist(process.argv.slice(2))
  const { text} = args
//   console.log(`Received text: ${text}`)
  // when user did ctrl+c and we have to upload to ipfs
  if(text !== undefined ){
    writeToClipboard(text)
    // Spawn a new process and run the put-files.js script with clipboard_content.txt as an argument
    const childProcess = spawn('node', ['put-files.js', 'clipboard_content.txt'])
    // Listen for any output from the child process
    childProcess.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`)
    })

    // Listen for any errors from the child process
    childProcess.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`)
    })

    // Listen for when the child process exits
    childProcess.on('close', (code) => {
    console.log(`child process exited with code ${code}`)
    })

  }
  else{
    // console.log("fetching is yet to be done")
    getLatestTextFile(TOKEN)
  }
}

main()
