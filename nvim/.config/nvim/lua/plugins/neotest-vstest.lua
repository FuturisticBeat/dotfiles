-- ~/.config/nvim/lua/plugins/neotest-vstest.lua

return {
  {
    "nvim-neotest/neotest",
    dependencies = { "Nsidorenco/neotest-vstest" },
    opts = {
      adapters = {
        ["neotest-vstest"] = {
          -- Configuration for the adapter can go here.
          -- Example: customize the path to your dotnet executable.
          -- dotnet_path = "dotnet",
        },
      },
    },
  },
}
