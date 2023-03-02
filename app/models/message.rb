class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", counter_cache: :sent_messages_count
  belongs_to :receiver, class_name: "User", counter_cache: :received_messages_count

end
