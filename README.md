# qtflow-builder

Container for building qtflow and backends and spitting out Debian packages

In order to access the work folder please execute docker the following way:

	mkdir build

For running an SSH server and connecting change the authorized keys file and execute:

	docker run --volume="`pwd`/build:/build:rw" --entrypoint=/ssh.sh IMAGE_ID

For automatically building the packages in the newly created build folder execute:

	docker run --volume="`pwd`/build:/build:rw" --entrypoint=/build.sh IMAGE_ID


The Debian packages and a source folder with an updated debian-folder (containing changelog and control files) will be available in the folder build

Status: WIP, compiles 0/4 successfully
