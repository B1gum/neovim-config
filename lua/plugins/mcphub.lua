return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@1.8.0",
    config = function()
        require("mcphub").setup()
    end
}
