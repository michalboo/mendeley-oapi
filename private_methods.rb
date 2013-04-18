module Private_methods

# stats methods

  def library_authors
    method_url = "/oapi/library/authors/"
    response = get_response(method_url)
  end

  def library_tags
    method_url = "/oapi/library/tags/"
    response = get_response(method_url)
  end

  def library_publications
    method_url = "/oapi/library/publications/"
    response = get_response(method_url)
  end

# document methods

  def library_documents(page=nil, items=nil)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/library/"
    response = get_response(method_url, options)
  end

  def library_authored(page=nil, items=nil)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/library/documents/authored/"
    response = get_response(method_url, options)
  end

  def library_doc_details(id)
    method_url = "/oapi/library/documents/#{id}/"
    response = get_response(method_url)
  end

  def create_document(document_json)
    method_url = "/oapi/library/documents/"
    body = { :document => document_json }
    response = post_response(method_url, body)
  end

  def update_document(id, document_json)
    method_url = "/oapi/library/documents/#{id}/"
    body = { :document => document_json }
    response = post_response(method_url, body)
  end

  def upload_file(id, file_name)
    method_url = "/oapi/library/documents/#{id}/"
    file_body = IO.read(file_name)
    sha1_hash = Digest::SHA1.hexdigest(file_body)
    response = put_response(method_url, file_name, file_body, sha1_hash) 
  end

  def download_file(id, file_hash, group_id=nil)
    method_url = "/oapi/library/documents/#{id}/file/#{file_hash}/"
    method_url << "#{group_id}/" if group_id
    options = Hash.new
    options[:with_redirect] = true
    response = get_response(method_url, options)
  end

  def delete_document(id)
    method_url = "/oapi/library/documents/#{id}/"
    response = delete_response(method_url)
  end

# folder methods

  def folders
    method_url = "/oapi/library/folders/"
    response = get_response(method_url)
  end

  def folder_documents(id, page=nil, items=nil)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/library/folders/#{id}/"
    response = get_response(method_url, options)
  end

  def add_document_to_folder(folder_id, doc_id)
    method_url = "/oapi/library/folders/#{folder_id}/#{doc_id}/"
    response = post_response(method_url)
  end

  def delete_document_from_folder(folder_id, document_id)
    method_url = "/oapi/library/folders/#{folder_id}/#{document_id}/"
    response = delete_response(method_url)
  end

  def create_folder(folder_json)
    method_url = "/oapi/library/folders/"
    body = { :folder => folder_json }
    response = post_response(method_url, body)
  end

  def delete_folder(folder_id)
    method_url = "/oapi/library/folders/#{folder_id}/"
    response = delete_response(method_url)
  end

# group methods

  def library_groups
    method_url = "/oapi/library/groups/"
    response = get_response(method_url)
  end

  def library_group_people(group_id)
    method_url = "/oapi/library/groups/#{group_id}/people/"
    response = get_response(method_url)
  end

  def group_documents(group_id, page=nil, items=nil)
    method_url = "/oapi/library/groups/#{group_id}/"
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    response = get_response(method_url, options)  
  end

  def group_doc_details(group_id, document_id)
    method_url = "/oapi/library/groups/#{group_id}/#{document_id}/"
    response = get_response(method_url)
  end

  def create_group_folder(group_id, folder_json)
    method_url = "/oapi/library/groups/#{group_id}/folders/"
    body = { :folder => folder_json }
    response = post_response(method_url, body)
  end

  def delete_group_folder(group_id, folder_id)
    method_url = "/oapi/library/groups/#{group_id}/folders/#{folder_id}/"
    response = delete_response(method_url)
  end

  def group_folders(group_id)
    method_url = "/oapi/library/groups/#{group_id}/folders/"
    response = get_response(method_url)
  end

  def group_folder_documents(group_id, folder_id)
    method_url = "/oapi/library/groups/#{group_id}/folders/#{folder_id}/"
    response = get_response(method_url)
  end

  def add_document_to_group_folder(group_id, folder_id, document_id)
    method_url = "/oapi/library/groups/#{group_id}/folders/#{folder_id}/#{document_id}/"
    response = post_response(method_url)
  end

  def delete_document_from_group_folder(group_id, folder_id, document_id)
    method_url = "/oapi/library/groups/#{group_id}/folders/#{folder_id}/#{document_id}/"
    response = delete_response(method_url)
  end

  def create_group(group_json)
    method_url = "/oapi/library/groups/"
    body = { :group => group_json }
    response = post_response(method_url, body)
  end

  def delete_group(group_id)
    method_url = "/oapi/library/groups/#{group_id}/"
    response = delete_response(method_url)
  end

  def leave_group(group_id)
    method_url = "/oapi/library/groups/#{group_id}/leave/"
    response = delete_response(method_url)
  end

  def unfollow_group(group_id)
    method_url = "/oapi/library/groups/#{group_id}/unfollow/"
    response = delete_response(method_url)
  end

  # profiles methods

  def contacts
    method_url = "/oapi/profiles/contacts/"
    response = get_response(method_url)
  end

  def add_contact(profile_id)
    method_url = "/oapi/profiles/contacts/#{profile_id}/"
    response = post_response(method_url)
  end

  def profile_information(profile_id="me", section=nil, subsection=nil)
    options = Hash.new
    options[:section] = section if section
    options[:subsection] = subsection if subsection
    method_url = "/oapi/profiles/info/#{profile_id}/"
    response  = get_response(method_url, options)
  end
end
