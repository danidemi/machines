Build an image that allows to run a self contained container running Wordpress.
The goal of this container is not to be used to actually host Wordpress, but just to have a personal
playground for it.

Build with

	docker build --rm=true --tag="cms:0.1" .
