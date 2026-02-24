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

		extraConfig = {
			credential.helper = "store";
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
