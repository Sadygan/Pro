# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md
bin_location = case Rails.env
  when 'production' then "/wherever/your/binary/is/bin/wkhtmltopdf"
  when 'development' then "/local/path/to/wkthmltopdf"
  else `which wkhtmltopdf`
end
WickedPdf.config = { :exe_path => bin_location }

# WickedPdf.config = {
#   # Path to the wkhtmltopdf executable: This usually isn't needed if using
#   # one of the wkhtmltopdf-binary family of gems.
#   # exe_path: '/usr/local/bin/wkhtmltopdf',
#   #   or
#   # exe_path: Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')

#   # Layout file to be used for all PDFs
#   # (but can be overridden in `render :pdf` calls)
#   # layout: 'pdf.html',

# }
