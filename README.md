# Installation

Prerequisites:
* [Docker Desktop](https://www.docker.com/get-started)

The following steps below can also be found [here](https://h5p.org/development-environment-docker).

Steps:
1. Clone repository and `cd` into project root
2. Start Drupal and MySQL: `docker-compose up -d`
3. Navigate to `http://localhost` to start installation. Use the following settings for the database step. Everything else can be whatever.
![](https://github.com/Languafe/h5p-docker-devenv-tut/raw/master/images/drupal-installation-db-config.png)
4. Go to [the module install page](http://localhost/admin/modules/install) and enable the "Update Manager" module
5. Install the [h5p Drupal plugin](https://ftp.drupal.org/files/projects/h5p-7.x-1.46.tar.gz) by uploading the file from the link above. Upon successful installation, click "Enable newly installed modules", then scroll to the bottom of the page to enable H5P and H5P Editor. Upon saving you will get an error message saying that the PHP max upload size is quite small (2 MB). We'll ignore this for now.
6. Navigate to Configuration > System > H5P (http://localhost/admin/config/system/h5p) and then check the two checkboxes labelled _Enable H5P development mode_ and _Enable library development directory._
7. SSH into the container: `docker exec -it $(docker ps -aqf "name=drupal") bash`
8. Create a symbolic link
```bash
cd /var/www/html/sites/default/files/h5p
mv development development-old
ln -s /mnt/h5pdev/ development

# When done, exit the shell using:
exit
```
9. Now if you navigate to `Content -> Add Content -> Interactive Content` you should see the greeting card component.