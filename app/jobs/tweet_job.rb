class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # binding.irb
    # byebug # 다른 툴인듯
    return if tweet.published?

    # Rescheduled a tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end

# Push the publish_at forward
# noon -> 8am
# -
# 8am -> sets tweet id
# noon -> published, does nothing

# Push the publish_at forward
# 9am -> 1pm
# -
# 9am -> should do nothing
# 1pm -> should publish the tweet and set the tweet_id