path "secret/data/buildkite/vault-buildkite-demo/*" {
  capabilities = ["read"]
}

path "secret/metadata/buildkite/*" {
  capabilities = ["list"]
}


