json.array! @papers.each do |paper|
  json.id paper.id
  json.title paper.title
end