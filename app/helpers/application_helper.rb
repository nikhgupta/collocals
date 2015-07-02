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
end
