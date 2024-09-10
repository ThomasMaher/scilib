json.id @paper.id
json.title @paper.title
json.year_published @paper.year_published
json.publisher @paper.publisher
json.content @paper.content
json.created_at @paper.created_at
json.updated_at @paper.updated_at
json.projects do
  json.array! @paper.projects.each do |project|
    json.id project.id
    json.title project.title
  end
end
json.unassigned_notes do
  json.array! @paper.unassigned_notes.each do |note|
    json.merge! note.attributes
  end
end