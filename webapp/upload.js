require('dotenv').config()
//
const FtpDeploy = require('ftp-deploy')
const ftpDeploy = new FtpDeploy()

const deloyAll = async () => {
  try {
    await ftpDeploy.deploy({
      host: process.env.FTP_HOST_NAME,
      user: process.env.FTP_HOST_USER,
      password: process.env.FTP_HOST_PASS,
      port: 21,
      localRoot: __dirname + '/dist',
      remoteRoot: `/${process.env.FTP_HOST_FOLDER}/`,
      include: ['*'],
      // e.g. exclude sourcemaps, and ALL files in node_modules (including dot files)
      exclude: [],
      // delete ALL existing files at destination before uploading, if true
      deleteRemote: true,
      // Passive mode is forced (EPSV command is not sent)
      forcePasv: true,
      // use sftp or ftp
      sftp: false
    })
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}

deloyAll()
