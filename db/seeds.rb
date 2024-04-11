# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
p1 = Paper.create(
  title: 'Science Jargon',
  year_published: 1990,
  publisher: 'A Very Good Science Place',
  content: 'This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... '
)
p2 = Paper.create(
  title: 'Neuro Jargon',
  year_published: 2004,
  publisher: 'A Very Good Science Place',
  content: 'This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... '
)
p3 = Paper.create(
  title: 'Psych Jargon',
  year_published: 2024,
  publisher: 'A Very Good Psychology Place',
  content: 'This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... This is a bunch of long content that goes on and on... '
)

pr1 = Project.create(
  title: 'Psychology Project'
)
pr2 = Project.create(
  title: 'Another Project'
)

ProjectPaper.create(
  project_id: pr1.id,
  paper_id: p2.id
)
ProjectPaper.create(
  project_id: pr1.id,
  paper_id: p3.id
)
ProjectPaper.create(
  project_id: pr2.id,
  paper_id: p1.id
)