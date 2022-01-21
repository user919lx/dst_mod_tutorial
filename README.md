# dst_mod_tutorial

Don't Starve Mod Tutorial 饥荒Mod教程，每个lesson都是一个独立的mod，可以直接放入`游戏根目录/mods`使用


文件结构
```
dst_mod_tutorial              //
├─ README.md                  //
└─ lesson3                    // 第三期Mod
   ├─ modicon.tex             // 
   ├─ modicon.xml             //
   ├─ modinfo.lua             //
   ├─ modmain.lua             // 主程序文件
   ├─ modworldgenmain.lua     //
   └─ scripts                 //
      ├─ components           //
      │  └─ ironhand.lua      // component定义
      └─ lf_actions.lua       // 动作相关参数
```