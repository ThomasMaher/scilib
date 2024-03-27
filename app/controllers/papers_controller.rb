class PapersController < ApplicationController

  def show
    @paper = fetch_data_for(:papers)[params.permit(:id)[:id]]
  end

  def index
    @papers = fetch_data_for(:papers).values
  end

  def new
    print('HELLLOLOOOOOOOOO')
    print('%%%%%%%%%%%%%%%%%%%')
  end

  def create
    count = get_count(fetch_data_for(:papers).values)
    tab = '  '
    id = (count.to_int + 1).to_s
    data = [
      "\n",
      "#{tab+id}:",
      "#{tab+tab}id: #{paper_params[:id]}",
      "#{tab+tab}title: #{paper_params[:title]}",
      "#{tab+tab}year: #{paper_params[:year]}",
      "#{tab+tab}publisher: #{paper_params[:publisher]}",
      "#{tab+tab}content: #{paper_params[:content]}",
    ].join("\n")
    File.write('../../config/data/papers.yml', data, mode: 'a')

    redirect_to paper_path(id)
  end


  private

  def paper_params
    params.require(:paper_params).permit(:title, :year, :publisher, :content)
  end

  def get_count(papers_list)
    papers_list.max { |paper| paper[:id].to_int }[:id].to_int
  end
end