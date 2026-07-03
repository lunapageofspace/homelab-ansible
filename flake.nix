{
  description = "Development shell for Ansible Homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        pythonWithPkgs = pkgs.python3.withPackages (ps: with ps; [
          openshift
          resolvelib
          black
          jsonschema
          netaddr
          pexpect
        ]);
      in {
        devShells.default = pkgs.mkShell {
          name = "ansible-shell";

          # Core packages for Ansible
          buildInputs = with pkgs; [
            ansible
            ansible-lint
            pythonWithPkgs
            yamllint
            bash
            jq
            yq
          ];

          # Optional: automatically install gems when entering the shell
          # (if a Gemfile exists)
          shellHook = ''
            echo "🔧 Setting up Ansible environment..."
            echo "📦 Installing Ansible collections and roles from requirements.yaml..."
            ansible-galaxy collection install -r ./.ansible/requirements.yaml --force
            ansible-galaxy role install -r ./.ansible/requirements.yaml --force
            echo "✅ Ready!"
          '';
        };
      }
    );
}