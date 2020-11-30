crumb :root do
  link "トップページ", root_path
end

crumb :clean_suggestions do
  link "掃除提案", clean_suggestions_path
  parent :root
end

crumb :suggestions do
  link "登録一覧", suggestions_path
  parent :clean_suggestions
end

crumb :new_suggestion do
  link "掃除箇所の登録", new_suggestion_path
  parent :clean_suggestions
end

crumb :desks do
  link "画像一覧", desks_path
  parent :root
end

crumb :new_desk do
  link "新規投稿画面", new_desk_path
  parent :desks
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).