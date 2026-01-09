local dap = require("dap")

dap.adapters.debugpy = {
	type = "server",
	port = "${port}",
	executable = {
		command = "debugpy",
	}
}

dap.configurations.python = {
	{
		type = "debugpy",
		request = "attach",
		name = "Debug python",
		cwd = "${workspaceFolder}",
		args = { '--connect', "${port}", '--wait-for-client' },
	}
}
