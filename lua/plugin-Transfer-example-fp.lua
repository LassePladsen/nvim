return {
  ["flightpark"] = {
    host = "flightpark",
    mappings = {
      {
        ["local"] = ".",
        ["remote"] = "/kunder/wp/f/fp2024/wp-utvikling",
      },
    },
    excludedPaths = {
      "wp-content/languages",
      "wp-content/meta",
      "wp-content/upgrade",
      "wp-content/upgrade-temp-backup",
      "wp-content/uploads",
      "wp-content/db.php",
      "**./*.zip",
      "wp-admin",
      "wp-includes",
      "**/node_modules", -- local path relative to project root
      "**/log",
      ".htaccess",
      "**/*.svg",
      "**/*.png",
      "**/*.ico",
      "wp-config.php",
      "**/cache",
      "**/images",
      "**/img",
      "**/templates_c",
    },
  },
}
