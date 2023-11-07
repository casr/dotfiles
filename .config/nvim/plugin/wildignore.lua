vim.opt.wildignore:append(table.concat({
  -- operating system
  ".AppleDouble,.DS_Store,.LSOverride,.DocumentRevisions-V100,.Spotlight-V100,.TemporaryItems,.Trashes,.VolumeIcon.icns,.com.apple.timemachine.donotpresent,.com.apple.timemachine.supported,.fseventsd,._*",

  -- archives
  "*.7z,*.bz2,*.bzip,*.bzip2,*.dmg,*.gz,*.iso,*.rar,*.tar,*.tgz,*.zip",

  -- images
  "*.bmp,*.gif,*.ico,*.jpeg,*.jpg,*.pdf,*.png,*.svgz,*.tif,*.tiff,*.webp",

  -- SCMs
  ".git/,.hg/,.svn/,CVS/",

  -- javascript
  "package-lock.json,*.tsbuildinfo",
}, ","))
