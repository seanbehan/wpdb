# Wpdb

An Active Record wrapper for the Wordpress Database

```ruby
require 'active_record'
require 'wpdb'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :host     => 'localhost',
  :port     => 3306,
  :username => 'root',
  :password => '',
  :database => 'your_db_name'
)

wp_post = Wpdb::WpPost.posts.last
puts wp_post.attributes
puts wp_post.wp_comments.map(&:attributes)
puts wp_post.categories
puts wp_post.tags
```
