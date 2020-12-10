
## zsh加载顺序

```bash
/etc/zshenv
~/.zshenv			环境变量的设置，例如PATH等，每一次无论什么操作都会调用
/etc/zprofile
~/.zprofile			与.zlogin类似，不经常改变的放到这里
/etc/zshrc
~/.zshrc
/etc/zlogin			与.zprofile类似，二选一即可
~/.zlogin
~/.zlogout			系统退出的时候做一些清理工作
/etc/zlogout
```

```bash
.zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].
```
