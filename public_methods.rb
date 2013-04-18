module Public_methods

  # stats methods
      
  def top_authors(discipline=nil, upandcoming=nil)
      options = Hash.new
      options[:discipline] = discipline if discipline
      options[:upandcoming] = upandcoming if upandcoming
      method_url = "/oapi/stats/authors/"
      response = get_response(method_url, options)
  end

  def top_papers(discipline=nil, upandcoming=nil)
    options = Hash.new
    options[:discipline] = discipline if discipline
    options[:upandcoming] = upandcoming if upandcoming
    method_url = "/oapi/stats/papers/"
    response = get_response(method_url, options)
  end

  def top_publications(discipline=nil, upandcoming=nil)
    options = Hash.new
    options[:discipline] = discipline if discipline
    options[:upandcoming] = upandcoming if upandcoming
    method_url = "/oapi/stats/publications/"
    response = get_response(method_url, options)
  end

  def top_tags(discipline)
    method_url = "/oapi/stats/tags/#{discipline}/"
    puts method_url
    response = get_response(method_url)
  end

  # catalog methods

  # @param [String] terms - search terms
  def document_search(term, page=nil, items=nil)
    encoded_term = URI.encode(term)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/documents/search/#{encoded_term}/"
    response = get_response(method_url, options)
  end

  def document_details(id, type=nil)
    options = Hash.new
    options[:type] = type if type
    method_url = "/oapi/documents/details/#{id}/"
    response = get_response(method_url, options)
  end

  def related_documents(id, page=nil, items=nil)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/documents/related/#{id}/"
    response = get_response(method_url, options)
  end

  def authored_documents(term, page=nil, items=nil, year=nil)
    encoded_term = URI.encode(term)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    options[:year] = year if year
    method_url = "/oapi/documents/authored/#{encoded_term}/"
    response = get_response(method_url, options)
  end

  def tagged_documents(term, page=nil, items=nil, cat=nil, subcat=nil)
    encoded_term = URI.encode(term)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    options[:cat] = cat if cat
    options[:subcat] = subcat if subcat
    method_url = "/oapi/documents/tagged/#{encoded_term}/"
    response = get_response(method_url, options)
  end

  def categories()
    method_url = "/oapi/documents/categories/"
    response = get_response(method_url)
  end

  def subcategories(category_id)
    method_url = "/oapi/documents/subcategories/#{category_id}/"
    response = get_response(method_url)
  end

  # public group methods

  def groups(page=nil, items=nil, cat=nil)
    options = Hash.new
    options[:page] = page if page
    options[:items] = items if items
    options[:cat] = cat if cat
    method_url = "/oapi/documents/groups/"
    response = get_response(method_url, options)
  end

  def group_details(id)
    method_url = "/oapi/documents/groups/#{id}/"
    response = get_response(method_url)
  end

  def group_papers(id, details=nil, page=nil, items=nil)
    options = Hash.new
    options[:details] = details if details
    options[:page] = page if page
    options[:items] = items if items
    method_url = "/oapi/documents/groups/#{id}/docs/"
    response = get_response(method_url, options)
  end

  def group_people(id)
    method_url = "/oapi/documents/groups/#{id}/people/"
    response = get_response(method_url)
  end
end
