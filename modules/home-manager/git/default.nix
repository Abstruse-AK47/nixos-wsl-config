{config,pkgs, ... }:

{

	programs.delta = {
		enable = true;
		enableGitIntegration = true;
		};

	programs.git = {
		enable = true;

		settings = {
			user = {
			name = "AK";
			email = "ayan344kapil@gmail.com";
		};

		init = {
			defaultBranch = "main";
			};
		pull = {
			rebase = true;
			};
		};
	};
	        
}
