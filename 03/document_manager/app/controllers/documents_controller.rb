class DocumentsController < ApplicationController
  def index
    if params[:today_only]
      @documents = Document.find(:all,
                   :conditions=>'parent_id IS NULL AND
                                 TO_DAYS(created_at)=
                                 TO_DAYS(NOW()) ')
    else
      @documents = Document.find(:all, :conditions=>'parent_id IS NULL')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @documents }
      format.zip do
        headers['Cache-Control'] = 'no-cache'

        tmp_filename = "#{RAILS_ROOT}/tmp/temp_zip_" <<
                        rand (10000) << "_" <<
                        Time.now.to_f.to_s << "-" <<
                        request.remote_ip <<
                        ".zip"
        Zip::ZipFile.open(tmp_filename,
                        Zip::ZipFile::CREATE) do |zip|
            text = render_to_string :partial=>'zip_index.text.erb',
                           :locals=>{:documents=>@documents}
            zip.get_output_stream('index.txt') do |zh|
              zh.puts text
            end
            html = render_to_string :partial=>'zip_index.html.erb',
                           :locals=>{:documents=>@documents}
            zip.get_output_stream('index.html') do |zh|
              zh.puts html
            end

            @documents.each do |doc|
              zip.add( "documents/#{doc.zip_filename}",
                       doc.full_filename )
            end
        end
        send_data File.open(tmp_filename,'rb+').read
        File.unlink tmp_filename
    end
  end

  end
  def show
    @document = Document.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @document }
    end
  end

  def new
    @document = Document.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @document }
    end
  end

  def create
    @document = Document.new(params[:document])
    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        format.html { redirect_to(@document) }
        format.xml { render :xml => @document,
                             :status => :created,
                             :location => @document }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @document.errors, ̄
                            :status => :unprocessable_entity }
      end
    end
  end
end

