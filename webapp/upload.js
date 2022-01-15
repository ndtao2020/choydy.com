require('dotenv').config()
//
const FtpDeploy = require('ftp-deploy')
const ftpDeploy = new FtpDeploy()

const host = process.env.FTP_HOST_NAME
const user = process.env.FTP_HOST_USER
const password = process.env.FTP_HOST_PASS

if (host && user && password) {
  ftpDeploy
    .deploy({
      host,
      user,
      password,
      port: 21,
      localRoot: __dirname + '/dist',
      remoteRoot: `/${process.env.FTP_HOST_FOLDER}/`,
      include: ['*'],
      // e.g. exclude sourcemaps, and ALL files in node_modules (including dot files)
      exclude: ['index.html'],
      // delete ALL existing files at destination before uploading, if true
      deleteRemote: false,
      // Passive mode is forced (EPSV command is not sent)
      forcePasv: true,
      // use sftp or ftp
      sftp: false
    })
    // eslint-disable-next-line no-console
    .then(() => console.log('Upload successfully !'))
    // eslint-disable-next-line no-console
    .catch((err) => console.log(err))
}
