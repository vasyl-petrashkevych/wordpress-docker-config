#!/bin/bash
PATH_TO_THEMES="/var/www/html/wp-content/themes"

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
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

  echo -e "${RED}Deactivate plugin akismet${NC}"
  wp plugin deactivate akismet --path="/var/www/html/"  --allow-root

  echo -e "${RED}Deactivate plugin hello${NC}"
  wp plugin deactivate hello --path="/var/www/html/"  --allow-root

  echo -e "${RED}Delete plugin akismet${NC}"
  wp plugin delete akismet --path="/var/www/html/"  --allow-root

  echo -e "${RED}Delete plugin hello${NC}"
  wp plugin delete hello --path="/var/www/html/"  --allow-root

  echo -e "${RED}Install plugin query-monitor${NC}"
  wp plugin install query-monitor --activate --path="/var/www/html/"  --allow-root

  echo -e "${RED}Install plugin wordpress-seo${NC}"
  wp plugin install wordpress-seo --activate --path="/var/www/html/"  --allow-root

  echo -e "${RED}Install plugin wp-mail-smtp${NC}"
  wp plugin install wp-mail-smtp --activate --path="/var/www/html/"  --allow-root


  echo -e "${RED}Change Permalink structure${NC}"
  wp rewrite structure '/%postname%/' --path="/var/www/html/"  --allow-root

  echo -e "${RED}Delete all pages${NC}"
  wp post delete $(wp post list --post_type='page' --format=ids --path="/var/www/html/"  --allow-root ) --path="/var/www/html/"  --allow-root --force

  echo -e "${RED}Delete all posts${NC}"
  wp post delete $(wp post list --post_type='post' --format=ids --path="/var/www/html/"  --allow-root ) --path="/var/www/html/"  --allow-root --force

  echo -e "${RED}Create Home Page${NC}"
  wp post create --post_type=page --post_title='Home'  --post_status=publish --path="/var/www/html/"  --allow-root
fi

chown -R www-data:www-data /var/www/html/
