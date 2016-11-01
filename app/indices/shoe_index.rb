# if Rails.env.development?
  ThinkingSphinx::Index.define :shoe, :with => :active_record, :delta => true do
    indexes title
    indexes description
  end
# end