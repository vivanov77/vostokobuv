# if Rails.env.development?
  ThinkingSphinx::Index.define :component, :with => :active_record, :delta => true do
    indexes title
    indexes description
  end
# end