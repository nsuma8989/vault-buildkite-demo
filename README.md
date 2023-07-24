# Buildkite+Vault Demo Repository

This repository contains some pieces to configure a local vault environment, and run a pipeline using the vault secrets buildkite plugin.

## Usage

Fork this repository and create a new pipeline in your Buildkite org, using the forked repository as the source. Leave the steps as default.

Create a new build, and watch vault do it's thing!

## Configuration

The pipeline located in `./buildkite` will run a vault server on the target agent (ideally, this should be a single persistent agent so that the config will be shared.)

Some setup on your agent is required to ensure the pipeline runs as expected 

Add this to your agent's `Environment hook`:

```shell
# This is configuration required for the vault server we are going to run
echo "~~~ :buildkite: agent :vault: config"
export VAULT_TOKEN="buildkite-is-cool"
export VAULT_DEV_ROOT_TOKEN_ID="${VAULT_TOKEN}"
export VAULT_ADDR="http://localhost:8200"

# This is where the agent will call vault to get the role ID and secret ID
export VAULT_ROLE_ID=$(vault read -field=role_id /auth/approle/role/buildkite/role-id)
export VAULT_SECRET_ID=$(vault write -f -field "secret_id" auth/approle/role/buildkite/secret-id)
```

Start your agent with the following command:

`buildkite-agent start --tags "queue=vault"`

## Requirements

You'll need:

- docker (I am currently using v20.10.11 Community edition)
- Buildkite agent
- A buildkite organization




