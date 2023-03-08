class Node < ApplicationRecord
  # Ancestry gem setup
  has_ancestry cache_depth: true

  # Constants for node types
  CLASS_NODE = "class"
  MODULE_NODE = "module"
  METHOD_NODE = "method"

  # Associations
  belongs_to :parent, class_name: "Node", optional: true
  has_many :children, class_name: "Node", foreign_key: "parent_id"

  # Validations
  validates :name, presence: true

  # Scopes
  scope :classes, -> { where(category: CLASS_NODE) }
  scope :modules, -> { where(category: MODULE_NODE) }
  scope :methods, -> { where(category: METHOD_NODE) }
end
