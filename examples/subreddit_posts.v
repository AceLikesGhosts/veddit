module main

import veddit

// gets all the posts from r/aww and logs them out
fn main() {
	posts := veddit.subreddit_posts_a('aww', 'new') or {
		println(err)
		return
	}

	// each post
	for child in posts.data.children {
		println('"${child.data.title}" by "${child.data.author}" at ${child.data.created_utc} UTC (${child.data.permalink})')
	}
}
