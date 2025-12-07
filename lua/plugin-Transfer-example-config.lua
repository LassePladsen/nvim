return {
  ["vipps"] = {
    host = "area51",
    mappings = {
      {
        ["local"] = ".",
        ["remote"] = "/home/devsites/wp/l/lassevippsdev/wp/wp-content/plugins/woo-vipps/payment",
      },
    },
    excludedPaths = {
      ".git", -- local path relative to project root
      ".php-cs-fixer*",
      "Session.vim",
    },
    upload_on_save = true
  },
}
