#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

PATH_TO_THEMES="/var/www/html/wp-content/themes"
PATH_TO_PLUGINS="/var/www/html/wp-content/plugins"
PLUGINS=("query-monitor" "wordpress-seo" "wp-mail-smtp" "duplicate-page")

# Check if WP CLI installed
echo "Start install WP CLI"
if [ -f "/usr/local/bin/wp" ]; then
  echo -e "${GREEN}WP CLI is installed${NC}"
else
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
fi

# Check if WordPress installed
if [ -d ${PATH_TO_THEMES} ]; then
  echo -e "${GREEN}WordPress is installed${NC}"
else
  echo -e "${RED}Start install WordPress${NC}"
  wp core download --path="/var/www/html/" --allow-root
  wp core install --path="/var/www/html/" --url="https://${SERVER_NAME}" --title="Your Blog Title" --admin_name=admin --admin_password=admin --admin_email=you@example.com --allow-root
fi

#Delete plugin akismet
if [ -d "${PATH_TO_PLUGINS}/akismet" ]; then
  echo -e "${RED}Deactivate plugin akismet${NC}"
  wp plugin deactivate akismet --path="/var/www/html/" --allow-root

  echo -e "${RED}Delete plugin akismet${NC}"
  wp plugin delete akismet --path="/var/www/html/" --allow-root
fi

#Delete plugin hello
if [ -f "${PATH_TO_PLUGINS}/hello.php" ]; then
  echo -e "${RED}Deactivate plugin hello${NC}"
  wp plugin deactivate hello --path="/var/www/html/" --allow-root

  echo -e "${RED}Delete plugin hello${NC}"
  wp plugin delete hello --path="/var/www/html/" --allow-root

fi

#Install plugins for start
for plugin_name in ${PLUGINS[@]}; do
  if ! [ -d "${PATH_TO_PLUGINS}/${plugin_name}" ]; then
    echo -e "${RED}Install plugin ${plugin_name}${NC}"
    wp plugin install $plugin_name --activate --path="/var/www/html/" --allow-root
  fi
done

echo -e "${RED}Change Permalink structure${NC}"
wp rewrite structure '/%postname%/' --path="/var/www/html/" --allow-root

echo -e "${RED}Delete all pages${NC}"
wp post delete $(wp post list --post_type='page' --format=ids --path="/var/www/html/" --allow-root) --path="/var/www/html/" --allow-root --force

echo -e "${RED}Delete all posts${NC}"
wp post delete $(wp post list --post_type='post' --format=ids --path="/var/www/html/" --allow-root) --path="/var/www/html/" --allow-root --force

echo -e "${RED}Create Home Page${NC}"
wp post create --post_type=page --post_title='Home' --post_status=publish --path="/var/www/html/" --allow-root

chown -R www-data:www-data /var/www/html/
