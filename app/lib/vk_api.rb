class VkApi
  include HTTParty

  base_uri 'https://api.vk.com/method'
  default_params v: "5.29"
end
