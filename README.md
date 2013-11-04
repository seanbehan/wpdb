# Wpdb

An Active Record wrapper for the Wordpress Database

```ruby
wp_post = WpPost.posts.last
puts wp_post.attributes
puts wp_post.comments
puts wp_post.wp_comments.map(&:attributes)
puts wp_post.categories
puts wp_post.tags
```
