# Installation

Prerequisites:
* [Docker Desktop](https://www.docker.com/get-started)
* [Node.js](https://nodejs.org/en)

The following steps below can also be found [here](https://h5p.org/development-environment-docker).

Steps:
1. Clone repository and `cd` into project root
2. Start Drupal and MySQL: `docker-compose up -d`
3. Navigate to `http://localhost` to start installation. Use the following settings for the database step. Everything else can be whatever.
![](https://github.com/Languafe/h5p-docker-devenv-tut/raw/master/images/drupal-installation-db-config.png)
4. Go to [the module install page](http://localhost/admin/modules/install) and enable the "Update Manager" module
5. Install the [h5p Drupal plugin](https://ftp.drupal.org/files/projects/h5p-7.x-1.46.tar.gz) by uploading the file from the link above. Upon successful installation, click "Enable newly installed modules", then scroll to the bottom of the page to enable H5P and H5P Editor. Upon saving you will get an error message saying that the PHP max upload size is quite small (2 MB). We'll ignore this for now.
6. Navigate to Configuration > System > H5P (http://localhost/admin/config/system/h5p) and then check the two checkboxes labelled _Enable H5P development mode_ and _Enable library development directory._
7. Go to `Content -> Add Content -> Interactive Content` and install the Interactive Video component. This initializes the folder structure. 
8. SSH into the container: `docker exec -it $(docker ps -aqf "name=drupal") bash`
9. Create a symbolic link
```bash
cd /var/www/html/sites/default/files/h5p
mv development development-old
ln -s /mnt/h5pdev/ development

# When done, exit the shell using:
exit
```

That's it for Drupal set up - the steps below will set everything up for development.

## Developing individual component repositories
1. Install webpack: `npm i -g webpack`
2. Run `git submodule update --init` to download the linked repositories
3. Run `sh build-repos.sh` to build dist files for each repo
4. Make your changes!
5. Now if you navigate to `Content -> Add Content -> Interactive Content` you should see your changes reflected.

NOTE: Each repository is a submodule and linked to a separate GitHub repository. If you are CD'd into a subrepository in the `repos` folder, `git` commands will apply to the subrepository. Similarly, `git` commands on the root will not apply to subrepositories.

## Troubleshooting
- If you get stuck, the easiest way is to re-clone this repo under a different name and do all the steps again. Drupal maintains a cache of some files that might make things hard to debug without a fresh install.