# create-nexus-staging-repo Github Action

This action creates a new staging repo so that you can upload all your files without having multiple implicit repos being created and your files in different places

# How to use it

Here is an example of how to use this action in your workflows.

```yaml
jobs:
  create_staging_repository:
    runs-on: ubuntu-latest
    name: Create staging repository
    outputs:
      repository-id: ${{ steps.create.outputs.repository-id }}
    steps:
      - id: create
        uses: nexus-actions/create-nexus-staging-repo@main
        with:
          username: ${{ secrets.SONATYPE_USERNAME }}
          password: ${{ secrets.SONATYPE_PASSWORD }}
          staging_profile_id: ${{ secrets.SONATYPE_PROFILE_ID }}
          description: ${{ github.repository }}/${{ github.workflow }}#${{ github.run_number }}
```

The different arguments are:

- `username`: Your Sonatype username, same the Sonatype Jira one
- `password`: Your Sonatype password, same the Sonatype Jira one
- `staging_profile_id`: Your staging profile ID. You can get it at https://oss.sonatype.org/#stagingProfiles;$staginProfileId
- `base_url`: The url of your nexus repository, default to OSSRH (https://oss.sonatype.org/service/local/)
- `[description]`: A description to identify the newly created repository ; default value='Created with Github Actions'

See the [nexus-actions-demo](https://github.com/nexus-actions/nexus-actions-demo) repo for more details and use cases.

----------

# This action is brought to you by ...

- Martin Bonnin from [Apollo GraphQL](https://www.apollographql.com)
- Romain Boisselle from [Kodein Koders](https://kodein.net)