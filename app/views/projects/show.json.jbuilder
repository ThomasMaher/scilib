json.id @project.id
json.title @project.title
json.created_at @project.created_at
json.updated_at @project.updated_at
json.papers do
  json.array! @project.papers&.each do |paper|
    json.id paper.id
    json.title paper.title
    json.year_published paper.year_published
  end
end