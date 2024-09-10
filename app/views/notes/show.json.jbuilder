json.message @status
json.errors flash[:errors]
json.id @note.id
json.quote @note.quote
json.note @note.note
json.project_paper_id @note.project_paper_id
json.paper_id @note.paper_id