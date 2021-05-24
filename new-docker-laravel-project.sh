echo""
echo "Welcome to the Laravel Docker installation"
echo ""

mkdir htdocs

cd htdocs

git clone --q git@github.com:mvd81/docker-laravel.git . > /dev/null

rm -r .git --force

# Rename project
read -p "Your project name (don't use special chars or spaces): " project_name

if [[ $project_name != "" && $project_name != "" ]]; then
sed -i "s/project_name/$project_name/" docker-compose.yml
sed -i "s/projectname/$project_name/" docker-compose.yml
sed -i "s/laravel_app/$project_name/" docker-compose.yml
sed -i "s/test_name_db/test_$project_name/" sql_scripts/create_test_db.sql
fi

# Nginx port
read -p "A free Ngnix port number: " nginx_port
if [[ $nginx_port != "" && $nginx_port != "" ]]; then
sed -i "s/8072/$nginx_port/" docker-compose.yml
fi

# PHP port
read -p "A free PHP port number: " php_port
if [[ $php_port != "" && $php_port != "" ]]; then
sed -i "s/9001/$php_port/" docker-compose.yml
fi

# Mysql port
read -p "A free Mysql port number: " mysql_port
if [[ $mysql_port != "" && $mysql_port != "" ]]; then
sed -i "s/3308/$mysql_port/" docker-compose.yml
fi

# Startup containers
docker-compose up -d --build > /dev/null

echo ""
echo "Download and installing the latest Laravel version....may take a while"
echo ""
docker-compose run composer create-project --prefer-dist laravel/laravel . > /dev/null

# Open the browser
start firefox -new-tab "http://localhost:$nginx_port"

### Your given input/options ###
echo "--------------------"
echo "Your input"
echo "--------------------"
echo "Project name: $project_name"
echo "Nginx port:   $nginx_port"
echo "PHP port:     $php_port"
echo "MYSQL port:   $mysql_port"
echo "--------------------"
echo ""

### Echo config settings ###

echo "--------------------"
echo "Change the settings in your .env file:"
echo "--------------------"
echo ""
echo "APP_URL=http://localhost:$nginx_port"
echo ""

echo "DB_CONNECTION=mysql"
echo "DB_HOST=mysql"
echo "DB_PORT=3306"
echo "DB_DATABASE=$project_name"
echo "DB_USERNAME=root"
echo "DB_PASSWORD=secret456"
echo ""
echo "TEST_DB_CONNECTION=mysql"
echo "TEST_DB_HOST=mysql"
echo "test_DB_PORT=3306"
echo "TEST_DB_DATABASE=test_$project_name"
echo "TEST_DB_USERNAME=root"
echo "TEST_DB_PASSWORD=secret456"

echo ""
echo "--------------------"
echo "In htdocs/src/config/database.php, add an item to the array"
echo "--------------------"
echo ""

echo "'test_db' => ["
echo "            'driver' => 'mysql',"
echo "            'host' => env('TEST_DB_HOST', '127.0.0.1'),"
echo "            'port' => env('TEST_DB_PORT', '3306'),"
echo "            'database' => env('TEST_DB_DATABASE', 'forge'),"
echo "            'username' => env('TEST_DB_USERNAME', 'forge'),"
echo "            'password' => env('TEST_DB_PASSWORD', ''),"
echo "        ],"

echo ""
echo "--------------------"
echo "In htdocs/src/phpunit.xml"
echo "--------------------"
echo ""
echo "<env name=\"DB_CONNECTION\" value=\"test_db\"/>"

cd ..

#// Remove this installation script sh script.
rm new-docker-laravel-project.sh

