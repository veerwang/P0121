如何使用pass管理密码

1.使用 gpg --gen-key 生成gpg密钥

2.使用 gpg --list-keys 显示相关的密钥信息

3.使用 pass init "gpg密钥的keyid,通过gpg --list-keys查看"

4.使用 pass insert github.com/kevin.wang2004 添加相关的密码

5.生成的密码被gpg加密后存储在.password_store目录中
