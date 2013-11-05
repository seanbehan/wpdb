require "wpdb/version"

module Wpdb
  class WpPost < ActiveRecord::Base
    has_many :wp_comments, foreign_key: :comment_post_ID
    has_many :wp_term_relationships, foreign_key: :object_id
    has_many :wp_term_taxonomies, through: :wp_term_relationships

    scope :posts, -> { where(post_type: 'post') }
    scope :published, -> { where(post_status: 'publish')}

    def wp_tags
      wp_term_taxonomies.tags.map { |wp_term_taxonomy| wp_term_taxonomy.wp_terms.map(&:to_tag) }.flatten
    end

    def wp_categories
      wp_term_taxonomies.categories.map { |wp_term_taxonomy| wp_term_taxonomy.wp_terms.map(&:to_tag) }.flatten
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
    self.primary_key = 'term_taxonomy_id'
    has_many :wp_term_relationships, foreign_key: :term_taxonomy_id
    has_many :wp_posts, through: :wp_term_relationships
    has_many :wp_terms, foreign_key: :term_id, primary_key: :term_id

    scope :tags,        -> { where(taxonomy: 'post_tag') }
    scope :categories,  -> { where(taxonomy: 'category') }

  end

  class WpTerm < ActiveRecord::Base
    belongs_to :wp_term_taxonomy, foreign_key: :term_taxonomy_id

    def to_tag
      {slug => name}
    end
  end
end
