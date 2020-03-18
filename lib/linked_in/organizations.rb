module LinkedIn
  # Organizations API
  #
  # @see https://developer.linkedin.com/docs/guide/v2/organizations
  #
  # [(contribute here)](https://github.com/mdesjardins/linkedin-v2)
  class Organizations < APIResource
    # Retrieve an Organization
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-lookup-api
    #
    # @macro organization_path_options
    # @option options [String] :scope
    # @option options [String] :type
    # @option options [String] :count
    # @option options [String] :start
    # @return [LinkedIn::Mash]
    def organization(options = {})
      path = organization_path(options)
      get(path, options)
    end
    
    def organization_image_urls(id)
      path = organization_image_path(id)
      get(path, {})
    end

    # Retrieve an Organization Brand
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-lookup-api
    #
    # @macro brand_path_options
    # @option options [String] :scope
    # @option options [String] :type
    # @option options [String] :count
    # @option options [String] :start
    # @return [LinkedIn::Mash]
    def brand(options = {})
      path = brand_path(options)
      get(path, options)
    end
    
    def brand_image_urls(id)
      path = brand_image_path(id)
      get(path, {})
    end

    # Retrieve Organization Access Control informaion
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-lookup-api#acls
    #
    def organization_acls(options = {})
      puts "trying things out2"
      org_acls_urn = options.delete(:org_acls_urn)
      org_acls_admin = options.delete(:org_acls_admin)
      q_val = org_acls_urn ? 'organization' : 'roleAssignee'
      org_parm_part = org_acls_urn ? "&organization=#{org_acls_urn}" + (org_acls_admin ? "&role=ADMINISTRATOR&state=APPROVED" : "") : ""
      path = "/organizationAcls?q=#{q_val}#{org_parm_part}"
      get(path, options)
    end

    # Perform a keyword-based Organization search sorted by relevance
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-search
    #
    # @macro organization_path_options
    # @option options [String] :scope
    # @option options [String] :type
    # @option options [String] :count
    # @option options [String] :start
    # @return [LinkedIn::Mash]
    def organization_search(options = {})
      path = "/search?q=companiesV2&baseSearchParams.keywords=#{CGI.escape(options[:keyword])}&projection=(metadata,elements*(entity~),paging)"
      get(path, options)
    end

    # TODO MOVE TO SHARES FOR EVERYTHING.
    # # Retrieve a feed of event shares for an Organization
    # #
    # # @see http://developer.linkedin.com/reading-company-shares
    # #
    # # @macro organization_path_options
    # # @option options [String] :event-type
    # # @option options [String] :count
    # # @option options [String] :start
    # # @return [LinkedIn::Mash]
    # def organization_shares(options={})
    #   path = "#{organization_path(options)}/updates"
    #   get(path, options)
    # end

    # Retrieve statistics for a particular organization page
    #
    # Permissions: rw_organization
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/page-statistics
    #
    # @option urn [String] organization URN
    # @return [LinkedIn::Mash]
    def organization_page_statistics(options = {})
      path = "/organizationPageStatistics?q=organization&organization=#{options.delete(:urn)}"
      get(path, options)
    end

    # Retrieve statistics for a particular organization followers
    #
    # Permissions: rw_organization
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/follower-statistics
    #
    # @option urn [String] organization URN
    # @return [LinkedIn::Mash]
    def organization_follower_statistics(options = {})
      path = "/organizationalEntityFollowerStatistics?q=organizationalEntity&organizationalEntity=#{options.delete(:urn)}"
      get(path, options)
    end

    # Retrieve statistics for a particular organization shares
    #
    # Permissions: rw_organization
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/share-statistics
    #
    # @option urn [String] organization URN
    # @return [LinkedIn::Mash]
    def organization_share_statistics(options = {})
      path = "/organizationalEntityShareStatistics?q=organizationalEntity&organizationalEntity=#{options.delete(:urn)}"
      get(path, options)
    end

    # Retrieve Organization Follower Count
    #
    # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/community-management/organizations/organization-lookup-api#retrieve-organization-follower-count
    #
    def organization_follower_count(organization_urn)
      path = "/networkSizes/#{organization_urn}?edgeType=CompanyFollowedByMember"
      get(path)
    end

    # TODO MOVE TO SOCIAL ACTIONS.
    #
    # # Retrieve comments on a particular company update:
    # #
    # # @see http://developer.linkedin.com/reading-company-shares
    # #
    # # @param [String] update_key a update/update-key representing a
    # #   particular company update
    # # @macro organization_path_options
    # # @return [LinkedIn::Mash]
    # def company_updates_comments(update_key, options={})
    #   path = "#{organization_path(options)}/updates/key=#{update_key}/update-comments"
    #   get(path, options)
    # end

    # # Retrieve likes on a particular company update:
    # #
    # # @see http://developer.linkedin.com/reading-company-shares
    # #
    # # @param [String] update_key a update/update-key representing a
    # #   particular company update
    # # @macro organization_path_options
    # # @return [LinkedIn::Mash]
    # def company_updates_likes(update_key, options={})
    #   path = "#{organization_path(options)}/updates/key=#{update_key}/likes"
    #   get(path, options)
    # end

    # # Create a share for a company that the authenticated user
    # # administers
    # #
    # # Permissions: rw_company_admin
    # #
    # # @see http://developer.linkedin.com/creating-company-shares
    # # @see http://developer.linkedin.com/documents/targeting-company-shares Targeting Company Shares
    # #
    # # @param [String] company_id Company ID
    # # @macro share_input_fields
    # # @return [void]
    # def add_company_share(company_id, share)
    #   path = "/companies/#{company_id}/shares?format=json"
    #   defaults = {visibility: {code: "anyone"}}
    #   post(path, MultiJson.dump(defaults.merge(share)), "Content-Type" => "application/json")
    # end

    # # (Create) authenticated user starts following a company
    # #
    # # @see http://developer.linkedin.com/documents/company-follow-and-suggestions
    # #
    # # @param [String] company_id Company ID
    # # @return [void]
    # def follow_company(company_id)
    #   path = "/people/~/following/companies"
    #   post(path, {id: company_id})
    # end

    # # (Destroy) authenticated user stops following a company
    # #
    # # @see http://developer.linkedin.com/documents/company-follow-and-suggestions
    # #
    # # @param [String] company_id Company ID
    # # @return [void]
    # def unfollow_company(company_id)
    #   path = "/people/~/following/companies/id=#{company_id}"
    #   delete(path)
    # end


    private ##############################################################

    # FIELDS specified in the URL are camel case while in code, they are separated by _
    ORGANIZATION_FIELDS = ["description", "alternativeNames", "specialties", "staffCountRange", "localizedSpecialties", "primaryOrganizationType", "id", "localizedDescription", "localizedWebsite", "vanityName", "website", "localizedName", "foundedOn", "coverPhoto", "groups", "organizationStatus", "versionTag", "defaultLocale", "organizationType", "industries", "name", "locations", "$urn"].join(",")

    # ID, IDS, URN versions should be for admins only...exception if not admin
    # EMAIL_DOMAIN, VANITY_NAME versions can be for non-admins
    def organization_path(options)
      path = '/organizations'

      if email_domain = options.delete(:email_domain)
        path += "?q=emailDomain&emailDomain=#{CGI.escape(email_domain)}"
      elsif id = options.delete(:id)
        if detailed = options.delete(:detailed)
          path += "/#{id}?projection=(#{ORGANIZATION_FIELDS},coverPhotoV2(original~:playableStreams,cropped~:playableStreams,cropInfo),logoV2(original~:playableStreams,cropped~:playableStreams,cropInfo))"
        else
          path += "/#{id}"
        end
      elsif ids = options.delete(:ids)
        if detailed = options.delete(:detailed)
          path += "?ids=List(#{ids})&projection=(#{ORGANIZATION_FIELDS},coverPhotoV2(original~:playableStreams,cropped~:playableStreams,cropInfo),logoV2(original~:playableStreams,cropped~:playableStreams,cropInfo))"
        else
          path += "?ids=List(#{ids})"
        end
      elsif urn = options.delete(:urn)
        path += "/#{urn_to_id(urn)}"
      elsif vanity_name = options.delete(:vanity_name)
        path += "?q=vanityName&vanityName=#{CGI.escape(vanity_name)}"
      elsif cmd = options.delete(:cmd)
        path += "#{cmd}"
      else
        path += "/me"
      end
    end
    
    def organization_image_path(id)
      path = '/organizations'
      path += "/#{id}?projection=(id,description,localizedWebsite,alternativeNames,coverPhotoV2(original~:playableStreams,cropped~:playableStreams,cropInfo),logoV2(original~:playableStreams,cropped~:playableStreams,cropInfo))"
    end

    def brand_path(options)
      path = '/organizationBrands'

      if id = options.delete(:id)
        path += "/#{id}"
      elsif vanity_name = options.delete(:vanity_name)
        path += "?q=vanityName&vanityName=#{CGI.escape(vanity_name)}"
      elsif parent_urn = options.delete(:parent_urn)
        path = "/organizations?q=parentOrganization&parent=#{CGI.escape(parent_urn)}"
      elsif cmd = options.delete(:cmd)
        path += "#{cmd}"
      else
        path += "/me"
      end
    end
    
    def brand_image_path(id)
      path = '/organizationBrands'
      path += "/#{id}?projection=(id,coverPhotoV2(original~:playableStreams,cropped~:playableStreams,cropInfo),logoV2(original~:playableStreams,cropped~:playableStreams,cropInfo))"      
    end
  end
end
