%w[
  base
  version
  rfc822
  
  pagination
  taggable
  searchable
  has_subject_data
  
  subject
  
  comment
  company
  email
  group
  kase
  membership
  note
  person
  task
  user
  tag
  deal
  account
  deal_category
  task_category
  party
  recording
  subject_field
  subject_data

].each do |lib|
  require File.join(File.dirname(__FILE__), 'highrise', lib)
end
