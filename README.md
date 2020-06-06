# docker-openstack-client

Very simple docker image containing the openstack client

This docker container will expect typical openstack environment variables to be used directly by OpenStack. This also does not have an entrypoint defined (yet). Example usage:

1. define a file that contains the necessary openstack environment variables. This environment is passed directly into the openstack cli:

`OS_PROJECT_DOMAIN_NAME=default`
`OS_USER_DOMAIN_NAME=default`
`OS_PROJECT_NAME=someproject`
`OS_USERNAME=someusername`
`OS_REGION_NAME=SomeRegon`
`OS_PASSWORD=somepassword`
`OS_AUTH_URL=https://some.example.com:35357/v3`
`OS_IDENTITY_API_VERSION=3`

2. run it

`docker run --rm --env-file env_file cyverse/openstack-client openstack server list`
