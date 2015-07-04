module ApplicationHelper
  def fa_brand_icon brand, options = {}
    size = options.delete(:size)
    size = size.present? ? "fa-#{size}x" : ""
    options = {class: "#{size} fa-#{brand}-colored"}.merge(options)
    icon = options.delete(:icon) || brand
    fa_icon icon, options
  end

  def fa_provider_icon provider, options = {}
    icon = case provider.to_s
           when "google" then "google-plus-square"
           when "foursquare" then "foursquare"
           else "#{provider}-square"
           end
    fa_brand_icon provider, { size: 2, icon: icon }.merge(options)
  end

  def fa_button icon, url, text: nil
    text = text ? " #{text}" : ""
    text = fa_icon(icon, class: "fa-2x") + text
    link_to text, url, class: "btn btn-block btn-social btn-default btn-action"
  end

  def fa_provider_button provider, resource: resource_name, icon: false
    text = icon.blank? ? " Sign in with #{provider.to_s.titleize}" : ""
    text = fa_provider_icon(provider) + text
    url  = omniauth_authorize_path(resource, provider)
    link_to text, url, class: "btn btn-social#{icon ? "-icon" : ""} btn-#{provider} btn-block"
  end
end
