require "wpdb/version"

module Wpdb
  # wp_post = WpPost.posts.last
  # puts wp_post.attributes
  # puts wp_post.wp_comments.map(&:attributes)
  # puts wp_post.categories
  # puts wp_post.tags
  class WpPost < ActiveRecord::Base
    has_many :wp_comments, foreign_key: :comment_post_ID
    has_many :wp_term_relationships, foreign_key: :object_id
    has_many :wp_term_taxonomies, through: :wp_term_relationships

    scope :posts, -> { where(post_type: 'post') }
    scope :published, -> { where(post_status: 'publish')}

    def tags
      wp_term_taxonomies.tags.map { |wp_term_taxonomy| wp_term_taxonomy.list }.flatten
    end

    def categories
      wp_term_taxonomies.categories.map { |wp_term_taxonomy| wp_term_taxonomy.list }.flatten
    end
  end

  class WpComment < ActiveRecord::Base
    belongs_to :wp_post
  end

  class WpTermRelationship < ActiveRecord::Base
    belongs_to :wp_post, foreign_key: :object_id
    belongs_to :wp_term_taxonomy, foreign_key: :term_taxonomy_id
  end

  class WpTermTaxonomy < ActiveRecord::Base
    self.table_name = 'wp_term_taxonomy'
    has_many :wp_terms, foreign_key: :term_id
    has_many :wp_term_relationships, foreign_key: :term_taxonomy_id
    has_many :wp_posts, through: :wp_term_relationships

    scope :tags, -> { where(taxonomy: 'post_tag') }
    scope :categories, -> { where(taxonomy: 'category') }

    def list
      wp_terms.map { |wp_term| { wp_term.slug => wp_term.name } }.flatten
    end
  end

  class WpTerm < ActiveRecord::Base
    belongs_to :wp_term_taxonomy
  end
end
