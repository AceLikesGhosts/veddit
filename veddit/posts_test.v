module veddit

import net.http { get }
import json

// test_posts because r/aww has so many posts, we cant really test this. lol
fn test_posts() {
	mut resp := get("https://reddit.com/r/test/new.json")!
	mut our_posts := json.decode(Posts, resp.body)!

	mut fetched_posts := subreddit_posts_a('test', 'new')!

	assert our_posts == fetched_posts
}
