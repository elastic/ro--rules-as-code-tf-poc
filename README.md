# Rules as code - Terraform PoC

## Disclamer

This is a PoC and as it, it's only meant to learn as much as possible. We might as well as we might not end up using Terraform nor anything related. Therefore it's important to us keep improving our APIs and JSON payloads so they can be used by whatever tool to run "as code"

## Current status

- [Weekly update](https://docs.google.com/presentation/d/1JXawPBALL3vcm8Yfs-BRGHM_GmNUPnkrPzdcWvt81sE/edit?usp=sharing)

## Try it out

### Prerequisites

This PoC was build/run using v8.5.3 so it might be needed if there are breaking changes. For now it's not mandatory but in case you need it:
  - Start Kibana 8.5.3 branch
  - Use 8.5.3 ES build `yarn es snapshot --version 8.5.3`

Must:
- Kibana must be running without base path, `yarn start --no-base-path` (important to add the no-base-path flag is it's the hardcoded url called by our patch)
- Having fetched the PoC branch you'll find under https://github.com/jcger/terraform-provider-elasticstack/tree/poc (Check out the prerequisites there)
- Having installed the PoC branch build locally by running `make install` in the provider repo
- Having ES and Kibana working, it's set up to the default parameters but they can be updated

### Run it

- Initialize terraform running `terraform init`
- Apply changes by running `terraform apply`

Everything we now is written somewhere in the weekly update slides
