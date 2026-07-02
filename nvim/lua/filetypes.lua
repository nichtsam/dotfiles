vim.filetype.add {
  pattern = {
    ["%.env%..+"] = "sh",
    ["%.dev%.vars"] = "sh",
    ["%.dev%.vars%..+"] = "sh",
  },
}
