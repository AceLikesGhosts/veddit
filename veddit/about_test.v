module veddit

import net.http { get }
import json

// test_user this is such a bad test. but like, it works? ig.
fn test_about_user() {
	mut resp := get('https://reddit.com/user/admin/about.json')!
	our_user := json.decode(User, resp.body)!

	mut fetched_suer := about_user('admin')!
	assert our_user == fetched_suer
}
