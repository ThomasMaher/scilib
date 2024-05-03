require 'fileutils'
require 'rmagick'

module ApplicationHelper
  def paper_pages(title)
    raise StandardError, 'File not found.' if title.blank?

    main_path = Rails.root.join('app', 'assets')
    output_path = File.join(main_path, 'images', title)
    convert_pdf_to_png(main_path, "#{title}.pdf", output_path)

    Dir.glob("app/assets/images/#{title}/*.png")
  end

  def convert_pdf_to_png(main_path, pdf_name, output_path)
    return if File.file?(output_path)

    pdf_path = File.join(main_path, 'papers', pdf_name)
    raise(
      StandardError,
      "File not found. Make sure a PDF titled #{pdf_name} has been placed under #{File.join(main_path, 'papers')}"
    ) unless File.file?(pdf_path)

    FileUtils.mkdir_p(output_path.to_s)

    pdf = Magick::ImageList.new(pdf_path)
    if pdf.format == "PDF"
      pdf.write(output_path + "/page" + ".png")
    else
      raise StandardError, "Please enter valid PDF file path!"
    end
  end
end
