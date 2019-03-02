"=============================================================================================
"
" Authot: 	kevin.wang
" Date:   	2019.03.02
" Description:  设置菜单的功能
"
"=============================================================================================

map <silent> <space><space> :VenuPrint<cr>

let s:bookmenu = venu#create('书签')
call venu#addItem(s:bookmenu, '添加书签', ':BookmarkToggle')
call venu#addItem(s:bookmenu, '备注书签', ':BookmarkAnnotate')
call venu#addItem(s:bookmenu, 'Next书签', ':BookmarkNext')
call venu#addItem(s:bookmenu, 'Prev书签', ':BookmarkPrev')
call venu#addItem(s:bookmenu, '显示书签', ':BookmarkShowAll')
call venu#addItem(s:bookmenu, '清除书签', ':BookmarkClear')
call venu#register(s:bookmenu)

let s:programmenu = venu#create('编程')
call venu#addItem(s:programmenu, 'Add C/C++ Head Flag', ':HeaderguardAdd')
call venu#addItem(s:programmenu, 'File Browse', ':NERDTreeToggle')
call venu#addItem(s:programmenu, 'File Structure', ':TagbarToggle')
call venu#addItem(s:programmenu, 'Undo Tree', ':UndotreeToggle')
call venu#register(s:programmenu)

let s:gitmenu = venu#create('版本管理')
call venu#addItem(s:gitmenu, 'Git Status', ':Gstatus')
call venu#addItem(s:gitmenu, 'Git Log', ':Gitv')
call venu#addItem(s:gitmenu, 'Git File Log', ':AgitFile')
call venu#addItem(s:gitmenu, 'Git Brnch Log', ':call GITLOG_ToggleWindows()')
call venu#addItem(s:gitmenu, 'Git Branch', ':MerginalToggle')
call venu#addItem(s:gitmenu, 'Tig Browse', ':TigOpenProjectRootDir')
call venu#addItem(s:gitmenu, 'Tig Blame', ':TigBlame')
call venu#register(s:gitmenu)

let s:projectmenu = venu#create('工程')
call venu#addItem(s:projectmenu, '主页', ':Startify')
call venu#addItem(s:projectmenu, '保存', ':SSave')
call venu#register(s:projectmenu)

let s:searchmenu = venu#create('Search')
call venu#addItem(s:searchmenu, 'File Search of Leadf', ':LeaderfFile')
call venu#addItem(s:searchmenu, 'File Search of Ag', ':Ag')
call venu#addItem(s:searchmenu, 'English', ':call SearchWord()')
call venu#register(s:searchmenu)

let s:bashmenu = venu#create('终端')
call venu#addItem(s:bashmenu, '终端', ':terminal')
call venu#register(s:bashmenu)

let s:noteconfigmenu = venu#create('备忘录')
call venu#addItem(s:noteconfigmenu, '我的备忘录', ':Note mynotes')
call venu#register(s:noteconfigmenu)

let s:plugmenu = venu#create('插件管理')
call venu#addItem(s:plugmenu, '安装插件', ':PlugInstall')
call venu#addItem(s:plugmenu, '清除插件', ':PlugClean')
call venu#addItem(s:plugmenu, '更新插件', ':PlugUpdate')
call venu#addItem(s:plugmenu, '升级 vim-plug', ':PlugUpgrade')
call venu#register(s:plugmenu)

let s:winmenu = venu#create('窗体')
call venu#addItem(s:winmenu, '新建标签', ':tabnew')
call venu#addItem(s:winmenu, '新建窗体', ':vsp')
call venu#addItem(s:winmenu, '增加宽度', ':vertical res +5')
call venu#addItem(s:winmenu, '减小宽度', ':vertical res -5')
call venu#addItem(s:winmenu, '增加高度', ':res +5')
call venu#addItem(s:winmenu, '减小高度', ':res -5')
call venu#register(s:winmenu)

let s:vimconfigmenu = venu#create('配置')
call venu#addItem(s:vimconfigmenu, 'vim 配置', ':edit ~/.vimrc')
call venu#addItem(s:vimconfigmenu, '设置背景颜色', ':Colors')
call venu#addItem(s:vimconfigmenu, '版本', ':version')
call venu#addItem(s:vimconfigmenu, '帮助', ':tab help')
call venu#register(s:vimconfigmenu)
