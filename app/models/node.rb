class Node < ApplicationRecord
  has_ancestry cache_depth: true
end
