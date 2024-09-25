json.array! @projects.each do |project|
  json.id project.id
  json.title project.title
  json.papers do
    json.array! project.papers.each do |paper|
      json.id paper.id
      json.title paper.title
      json.year_published paper.year_published
      json.publisher paper.publisher
      json.content paper.content
    end
  end
end