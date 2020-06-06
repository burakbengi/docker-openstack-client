# docker-openstack-client

Very simple docker image containing the openstack client

This docker container will expect typical openstack environment variables to be used directly by OpenStack. This also does not have an entrypoint defined (yet). Example usage:

docker run --rm --env-file env_file cyverse/openstack-client /usr/bin/openstack server list -f json --long

See env_file.sample for an example of an env_file to pass along
