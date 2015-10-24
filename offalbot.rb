require 'slack-ruby-client'
require 'uri'

TRIGGERS = ["awful", "offal", "brain", "liver" "kidney", "stomach", "tripe", "tongue", "testicle", "colon", "spleen", "lung"]

OFFAL = [
          "Blood sausages are sausages filled with blood that are cooked or dried and mixed with a filler until they are thick enough to congeal when cooled. The dish is found world-wide. Pig, cattle, sheep, duck, and goat blood can be used depending on different countries",
          "Tripe is a type of edible offal from the stomachs of various farm animals",
          "In Norway the smalahove is a traditional dish, usually eaten around and before Christmas time, made from a sheep's head. The skin and fleece of the head is torched, the brain removed, and the head is salted, sometimes smoked, and dried. The head is boiled for about 3 hours and served with mashed rutabaga/swede and potatoes.",
          "Haggis is a savoury pudding containing sheep's pluck (heart, liver and lungs); minced with onion, oatmeal, suet, spices, and salt, mixed with stock, traditionally encased in the animal's stomach though now often in an artificial casing instead.",
          "In Poland, Kaszanka is a traditional sausage similar to black pudding, is made with a mixture of pig's blood, pig offal and buckwheat or barley usually served fried with onions or grilled.",
          "Criadillas or huevos de toro (\"bull's eggs\", testicles) are eaten mostly in cattle-raising regions, while cow udder (\"ubres\") is served fried or boiled.",
          "In Malaysia, cow or goat lung, called paru, coated in turmeric and fried is often served as a side dish to rice, especially in the ever popular nasi lemak.",
          "Tiết canh is a traditional dish of blood and cooked meat in northern Vietnamese cuisine. The most popular is tiết canh vịt, made from raw duck blood and duck meat.",
          "In Bangladesh, a bull's or goat's brain (mogoj), feet (paya), head (matha), stomach skin (bhuri), tongue (jib-ba), liver (kolija), lungs (fepsha), kidney and heart (gurda) are delicacies.",
          "Several types of offal are commonly used in tacos, including, tacos de lengua: boiled beef tongue, tacos de sesos: beef brain, tacos de cabeza: every part of the cow's head, including lips, cheeks, eyes, etc., tacos de ojo: cow's eyes, tacos de chicharrón: fried pork rinds (chicharrón), a common snack food item, tacos de tripas: beef tripe (tripas)"
        ]

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self['name']}' to the '#{client.team['name']}' team at https://#{client.team['domain']}.slack.com."
end

client.on :message do |data|
  # It may be possible that you get a message with no text
  if data['text']
    if TRIGGERS.any? { |word| data['text'].include?(word) }
      client.message channel: data['channel'], text: OFFAL.sample
    end
  end
end

client.start!
